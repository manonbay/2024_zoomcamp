with 

source as (

    select * from {{ source('staging', 'tlc_green_trips_2020') }}

),

renamed as (
        select
            -- identifiers
            {{ dbt_utils.generate_surrogate_key(['vendor_id ', 'pickup_datetime']) }} as tripid,
            {{ dbt.safe_cast("vendor_id ", api.Column.translate_type("integer")) }} as vendor_id ,
            cast(replace(rate_code,'.0','') as integer) as rate_code,
            {{ dbt.safe_cast("pickup_location_id", api.Column.translate_type("integer")) }} as pickup_location_id,
            {{ dbt.safe_cast("dropoff_location_id", api.Column.translate_type("integer")) }} as dropoff_location_id,

            -- timestamps
            cast(pickup_datetime as timestamp) as pickup_datetime,
            cast(dropoff_datetime as timestamp) as dropoff_datetime,

            -- trip info
            store_and_fwd_flag,
            {{ dbt.safe_cast("passenger_count", api.Column.translate_type("integer")) }} as passenger_count,
            cast(trip_distance as numeric) as trip_distance,
            cast(replace(trip_type,'.0','') as integer) as trip_type,

            -- payment info
            cast(fare_amount as numeric) as fare_amount,
            cast(extra as numeric) as extra,
            cast(mta_tax as numeric) as mta_tax,
            cast(tip_amount as numeric) as tip_amount,
            cast(tolls_amount as numeric) as tolls_amount,
            cast(imp_surcharge as numeric) as imp_surcharge,
            cast(total_amount as numeric) as total_amount,
            -- cast(payment_type as integer) as payment_type_test2, # Encountered an error: Runtime Error Database Error in sql_operation inline_query (from remote system.sql) Bad int64 value: 2.0
            -- cast(payment_type as numeric) as payment_type_test3, # works fine but display float in dbt
            cast(replace(payment_type,'.0','') as integer) as payment_type,
            {{ get_payment_type_description('payment_type') }} as payment_type_description,
        from source
    )

select *
from renamed

-- dbt build --select stg_tlc_green_trips_2020 --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}