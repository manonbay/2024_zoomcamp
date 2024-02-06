if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    print("there is ", len(data[data["vendorid"].isna()]), " trips with no vendors ID")
    return data[data["vendorid"].notna()]

