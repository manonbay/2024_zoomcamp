with 

source as (select * from {{ source('staging', 'fhv2019') }}),

renamed as (

    select
        dispatching_base_num,
        cast(pickup_datetime as timestamp) as pickup_datetime,
        cast(dropOff_datetime as timestamp) as dropoff_datetime,
        {{ dbt.safe_cast("PUlocationID", api.Column.translate_type("integer")) }} as pickup_location_id,
        {{ dbt.safe_cast("DOlocationID", api.Column.translate_type("integer")) }} as dropoff_location_id,
        affiliated_base_number

    from source
    where pickup_datetime between "2019-01-01" and "2019-12-31" 
)

select * from renamed

-- dbt build --select stg_fhv2019.sql  --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}
  limit 100
{% endif %}