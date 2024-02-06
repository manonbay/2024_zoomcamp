if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform_lower_columns_names(data, *args, **kwargs):
    data.columns = data.columns.str.lower().str.replace(" ", "_")
    return data


