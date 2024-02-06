if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformerhttp://localhost:6789/pipelines/green_taxi_etl2/edit?sideview=tree#
def transform_green_taxi(data, *args, **kwargs):
    data.columns = data.columns.str.lower().str.replace(" ", "_")
    print(f'Preprocessing: rows with zero passengers : {data["passenger_count"].isin([0]).sum()}')
    data = data[data["passenger_count"]>0]
    print(f'Postprocessing: rows with zero passengers : {data["passenger_count"].isin([0]).sum()}')
    print(f'Preprocessing: rows with distance=0 : {len(data[data["trip_distance"] == 0])}')
    data = data[data["trip_distance"]!=0]
    print(f'Postprocessing: rows with distance=0 : {len(data[data["trip_distance"] == 0])}')
    print(f'Preprocessing: rows with no vendorID : {len(data[data["vendorid"].isna()])}')
    data =  data[data["vendorid"].notna()]
    print(f'Postprocessing: rows with no vendorID : {len(data[data["vendorid"].isna()])}')
    return data


@test
def test_output(output, *args) -> None:
    assert output is not None, 'The output is undefined'

@test
def test_output(output, *args):
    assert output["passenger_count"].isin([0]).sum() !=0, "There are rides with zero passengers"

@test
def test_output(output, *args) -> None:
    assert output["vendorid"].isna().sum()==0, 'There are trips with distance = 0'