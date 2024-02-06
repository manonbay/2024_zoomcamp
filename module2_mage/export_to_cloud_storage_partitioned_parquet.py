import pyarrow as pa
import pyarrow.parquet as pq
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "/home/src/classe-zoomcamp-ef200d809018.json"
project_id = 'classe-zoomcamp'
bucket_name = 'mage_zoom_homeworks_green'
table_name = "green"
root_path = f'{bucket_name}/{table_name}'

@data_exporter
def export_data_to_gcs_parquet(data, *args, **kwargs):

    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date
    table = pa.Table.from_pandas(data)
    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        table, 
        root_path= root_path, 
        partition_cols=['lpep_pickup_date'], 
        filesystem=gcs)