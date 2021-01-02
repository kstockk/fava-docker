FROM python:3.8-slim-buster as builder

RUN apt-get update
RUN apt-get install -y libxml2-dev libxslt-dev gcc musl-dev g++ git
RUN pip install fava

WORKDIR /tmp/build
RUN git clone https://github.com/lykhee/fetch-unit-prices

WORKDIR /tmp/build/fetch-unit-prices
RUN python setup.py install

FROM python:3.8-slim-buster
COPY --from=builder /usr/local /usr/local

RUN find /usr/local -name __pycache__ -exec rm -rf -v {} +

ENV BEANCOUNT_FILE ""
ENV FAVA_OPTIONS ""

EXPOSE 5000

CMD fava --host 0.0.0.0 $FAVA_OPTIONS $BEANCOUNT_INPUT_FILE
