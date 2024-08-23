{{ 
    config(materialized='ephemeral')
}}

with

orders as (

    select * from {{ ref('s3_orders') }}
    -- if you generate a larger dataset, you can limit the 
    -- timespan to the current time with the following line
    where ordered_at >= '{{ var("var_ordered_after") }}'
),

customers as (

    select * 
    from {{ ref('s3_customers') }}
)

select {{ dbt_utils.surrogate_key(['customers.customer_id']) }} customer_order_key, 
customer_name, sum(order_total) orders_value, sum(tax_paid) total_tax, 
count(order_id) as total_orders  
from customers
join orders on customers.customer_id = orders.customer_id  
group by 1,2
