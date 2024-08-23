{{ 
    config(materialized='incremental',
           alias=this.name + var('var_pno'),
           unique_key=['order_id','order_item_id','location_id','customer_id','product_id'],
           transient=false,
           schema='BUS',
          )
}}
{{  config(materialized='incremental',  ) }}

with 

ords as (
    
    select * from {{ ref('s5_orders')}}
    {% if is_incremental() %}
        where ordered_at > (select max(ordered_at) from {{this}})
    {% endif %}
),

itms as (
    
    select * from {{ ref('s3_order_items')}}

)

select ords.order_id, order_item_id, location_id, customer_id, product_id, 
        order_total, tax_paid, ordered_at from ords
inner join itms 
on ords.order_id = itms.order_id

