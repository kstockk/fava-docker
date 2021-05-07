FROM python:3.8-slim-buster as builder

RUN apt-get update
RUN apt-get install -y build-essential libxml2-dev libxslt-dev zlib1g-dev\
		      python-dev gcc musl-dev g++ git make \
		      && rm -rf /var/lib/apt/lists/*
RUN pip install fava fava[excel]

WORKDIR /tmp/build
RUN git clone https://github.com/lykhee/fetch-unit-prices

WORKDIR /tmp/build/fetch-unit-prices
RUN python setup.py install

RUN find /usr/local -name __pycache__ -exec rm -rf -v {} +

FROM python:3.8-slim-buster
COPY --from=builder /usr/local /usr/local

ENV BEANCOUNT_FILE ""
ENV FAVA_OPTIONS ""

EXPOSE 5000

CMD fava --host 0.0.0.0 $FAVA_OPTIONS $BEANCOUNT_INPUT_FILE
