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
        coalesce({{ dbt.safe_cast("payment_type", api.Column.translate_type("integer")) }},0) as payment_type,
        {{ get_payment_type_description("payment_type") }} as payment_type_description,
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
