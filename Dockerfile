# syntax=docker/dockerfile:1

FROM python:3.12.4-slim
WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt
COPY data-ingestion.py .
CMD [ "python", "data-ingestion.py"]
