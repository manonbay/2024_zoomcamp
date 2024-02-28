{% set models_to_generate = codegen.get_models(directory='course_taxi_rides_ny/staging', prefix='stg_') %}
{{ codegen.generate_model_yaml(
    model_names = models_to_generate
) }}

-- cliquer sur compile 