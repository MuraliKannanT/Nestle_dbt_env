{{ config(
    materialized='incremental',
    unique_key=['product_id'],
    alias =  this.name + var('var_pno'),
    schema = 'BUS',
    post_hook="{{ testing( this.database, this.schema, this.name, 's5_fct_orders','product_id','product_id' ) }}",
 ) }}

select  *, FALSE as inferred_flag from {{ ref('s3_products') }}
    {% if is_incremental() %}
        where updated_ts > (select max(updated_ts) from {{this}} )
    {% endif %}


