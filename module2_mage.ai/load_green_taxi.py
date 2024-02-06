import io
import pandas as pd

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

@data_loader
def load_data_from_api(*args, **kwargs):
    for month in [10, 11, 12] : 

        url = f'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-{month}.csv.gz'
        
        taxi_dtypes = {
                'VendorID': pd.Int64Dtype(),
                'store_and_fwd_flag':str,
                'RatecodeID':pd.Int64Dtype(),
                'PULocationID':pd.Int64Dtype(),
                'DOLocationID':pd.Int64Dtype(),
                'passenger_count': pd.Int64Dtype(),
                'trip_distance': float,
                'fare_amount': float,
                'extra':float,
                'mta_tax':float,
                'tip_amount':float,
                'tolls_amount':float,
                'ehail_fee' : float,
                'improvement_surcharge': float,
                'payment_type': pd.Int64Dtype(),
                'total_amount': float,
                'trip_type' : float,
                'congestion_surcharge':float
            }

        # native date parsing 
        parse_dates = ['lpep_pickup_datetime', 'lpep_dropoff_datetime']

        try:
            data = pd.concat([data, pd.read_csv(url, compression="gzip", dtype=taxi_dtypes, parse_dates=parse_dates)], ignore_index=True)
        
        except NameError:
            data = pd.read_csv(url, compression="gzip", dtype=taxi_dtypes, parse_dates=parse_dates)  
        
        data.reset_index(drop=True, inplace=True)
        
    return data