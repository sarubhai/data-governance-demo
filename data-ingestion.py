import requests
import psycopg2
import os

hostname = os.environ['DB_HOST']
port = os.environ['DB_PORT']
username = os.environ['DB_USERNAME']
password = os.environ['DB_PASSWORD']
database = os.environ['DB_NAME']


def download_file(url, destination):
    with requests.get(url, stream=True) as response:
        # Raise an exception for bad HTTP status codes
        response.raise_for_status()

        # Open the destination file in write-binary mode
        with open(destination, 'wb') as file:
            # Iterate over the response in chunks of 1MB (1024 * 1024 bytes)
            for chunk in response.iter_content(chunk_size=1024*1024):
                # Only write the chunk if it is not empty
                if chunk:
                    file.write(chunk)

    print(f"File downloaded successfully to: {destination}")


def ingest_data(source, table_name):
    try:
        conn = psycopg2.connect(
            host=hostname,
            port=port,
            user=username,
            password=password,
            dbname=database
        )
    
        copy_sql = f"COPY {table_name} FROM STDIN WITH CSV HEADER DELIMITER ','"
        file = open(source, "r")
        with conn.cursor() as cur:
            cur.execute(f"TRUNCATE TABLE {table_name}")
            cur.copy_expert(sql=copy_sql, file=file, size=1024*1024)
            conn.commit()
            cur.close()
            conn.close()
        print(f"File loaded successfully to: {table_name}")
    except:
        print(f"Error loading file {source} to: {table_name}")
    


# Covid Dataset
url = "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/country_data/United%20States.csv"
destination = "/tmp/covid.csv"
table_name = "stage.stg_covid_vaccination"
print(f"API Endpoint: {url}")
print(f"Staging Table: {table_name}")
download_file(url, destination)
ingest_data(destination, table_name)
