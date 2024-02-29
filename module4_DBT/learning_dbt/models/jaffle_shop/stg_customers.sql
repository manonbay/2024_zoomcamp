select 
*

from {{ source('jaffle_shop', 'raw_customers') }}


{% if var('is_test_run', default=true) %}
  limit 100
{% endif %}
