{{ 
    config(
            materialized='dynamic_table',
            alias=this.name + var('var_pno'),
            target_lag='1 minute',
            on_configuration_change='apply',
            refresh_mode='incremental',
            snowflake_warehouse='dbt_wh'
          )
}}

with

products as (

    select * from {{ ref('s5_products') }}

)

select product_type, count(product_id) total_products, sum(product_price) total_cost 
from products
group by 1



