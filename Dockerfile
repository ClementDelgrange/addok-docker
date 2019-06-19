FROM python:3.6

# Install system dependencies
RUN apt-get update && apt-get install -y build-essential git wget bzip2

# Install addok using cython
RUN pip install cython \
 && pip install --no-binary :all: falcon addok \
 && pip install addok-fr addok-france gunicorn

ENV ADDOK_CONFIG_FILE /etc/addok/addok.conf
ENV REDIS_HOST redis
ENV REDIS_PORT=6379
ENV REDIS_DB_INDEXES=0

COPY addok.conf /etc/addok/addok.conf
COPY entrypoint.sh /bin/entrypoint.sh

ENTRYPOINT ["sh", "/bin/entrypoint.sh"]