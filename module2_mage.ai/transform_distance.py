if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform_distance_sup_zero(data, *args, **kwargs):
    print(f'Preprocessing: rows with distance=0 : {len(data[data["trip_distance"] == 0])}')
    return data[data["trip_distance"]!=0]


@test
def test_output(output, *args) -> None:
    assert output is not None, 'The output is undefined'
