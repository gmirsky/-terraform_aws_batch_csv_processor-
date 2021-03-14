FROM python:3.9.2-alpine3.13
WORKDIR /usr/src
ADD . /usr/src
RUN python setup.py install
ENTRYPOINT ["python", "aws_batch_csv_processor"]
