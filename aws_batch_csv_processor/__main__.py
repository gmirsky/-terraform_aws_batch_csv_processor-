import boto3
import click
import csv
import io
import logging
import sys


class CsvS3Reader(
    object
):
    def __init__(self,
                 bucket,
                 key):
        s3 = boto3.resource('s3')
        response = s3.Object(bucket_name=bucket,
                             key=key
                             ).get()
        self.body = response['Body']

    def __iter__(self):
        """
        Return an iterator to yield lines from the raw stream.
        """
        # Read 1024 bytes at a time
        # If the user needs to specify something different they can always call
        # streaming_body._iter_lines(<other-chunk-size>)
        default_chunk_size = 1024
        return csv.reader(
            self._iter_lines(
                default_chunk_size
            )
        )

    def _iter_lines(
        self,
        chunk_size
    ):
        """
        Return an iterator to yield lines from the raw stream.

        This is achieved by reading chunk of bytes (of size chunk_size) at a
        time from the raw stream, and then yielding lines from there.
        """
        pending = None
        for chunk in self._iter_chunks(chunk_size):
            if pending is not None:
                chunk = pending + chunk

            lines = chunk.splitlines()

            if lines and lines[-1] and chunk and lines[-1][-1] == chunk[-1]:
                """
                We might be in the 'middle' of a line. Therefore we keep the
                last line as pending, just in case this situation arises.
                """
                pending = lines.pop()
            else:
                pending = None

            for line in lines:
                yield line

        if pending is not None:
            yield pending

    def _iter_chunks(
        self,
        chunk_size
    ):
        """
        Return an iterator to yield chunks of chunk_size bytes from the raw
        stream.
        """
        while True:
            current_chunk = self.body.read(chunk_size)
            if current_chunk == b"":
                break
            yield current_chunk

# pylint: disable=no-value-for-parameter


@click.command()
@click.argument('bucket')
@click.argument('path')
def process(
    bucket,
    path
):
    
    header = None 
    n = 0
    for row in CsvS3Reader(
        bucket,
        path
    ):
        """
        This routine streams the file and prints the number of data lines. 
        Add more code here to customize your batch processing.
        """
        if header is None:
            header = row
            print('Columns: %d' % len(row))
        else:
            n = n + 1
    print("n: ",
          n
          )


if __name__ == "__main__":
    process()
