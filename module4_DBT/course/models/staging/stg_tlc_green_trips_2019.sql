with 

source as (

    select * from {{ source('staging', 'tlc_green_trips_2019') }}

),

renamed as (

    select
        {{ dbt_utils.default__generate_surrogate_key(['vendor_id','pickup_datetime']) }} as tripid, 
        vendor_id,
        pickup_datetime,
        dropoff_datetime,
        store_and_fwd_flag,
        rate_code,
        passenger_count,
        trip_distance,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        ehail_fee,
        airport_fee,
        total_amount,
        payment_type,
        -- coalesce({{ dbt.safe_cast("payment_type", api.Column.translate_type("integer")) }},0) as payment_type_test1, # from the course : Not working, runs fine but replace all values with 0
        -- cast(payment_type as integer) as payment_type_test2, # Encountered an error: Runtime Error Database Error in sql_operation inline_query (from remote system.sql) Bad int64 value: 2.0
        -- cast(payment_type as numeric) as payment_type_test3, # works fine but display float in dbt
        cast(replace(payment_type,'.0','') as integer) as payment_type_test,
        distance_between_service,
        time_between_service,
        trip_type,
        imp_surcharge,
        pickup_location_id,
        dropoff_location_id,
        data_file_year,
        data_file_month

    from source

)

select * from renamed
