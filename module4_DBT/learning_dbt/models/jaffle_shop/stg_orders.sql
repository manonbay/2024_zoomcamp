select 

id as order_id,
user_id as customer_id,
order_date,
status

from {{ source('jaffle_shop', 'raw_orders') }}

{% if var('is_test_run', default=true) %}
  limit 100
{% endif %}