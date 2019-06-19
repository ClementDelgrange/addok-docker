#!/bin/bash

# Configure addok
if [ ! -f $ADDOK_CONFIG_FILE ]; then
  echo "Addok config file not found!"
  exit 1
fi

echo "LOG_DIR = '/logs'" >> $ADDOK_CONFIG_FILE

if [ "$LOG_QUERIES" = "1" ]; then
  echo Will log queries
  echo "LOG_QUERIES = True" >> $ADDOK_CONFIG_FILE
fi

if [ "$LOG_NOT_FOUND" = "1" ]; then
echo Will log Not Found
  echo "LOG_NOT_FOUND = True" >> $ADDOK_CONFIG_FILE
fi

if [ ! -z "$SLOW_QUERIES" ]; then
  echo Will log slow queries
  echo "SLOW_QUERIES = ${SLOW_QUERIES}" >> $ADDOK_CONFIG_FILE
fi

# Download ODbL BAN data and uncompress it
mkdir /data
cd /data
wget http://bano.openstreetmap.fr/BAN_odbl/BAN_odbl_93-json.bz2
bunzip2 BAN_odbl_93-json.bz2

# Import the data
addok batch BAN_odbl_93-json
addok ngrams

# Start addok with gunicorn
gunicorn -w $WORKERS --timeout $WORKER_TIMEOUT -b 0.0.0.0:7878 --access-logfile - addok.http.wsgi
