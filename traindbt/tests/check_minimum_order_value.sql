
with orders as (
    select * from {{ ref('s3_orders') }}
)

select order_id, sum(order_total) ordertotal from orders
group by 1 
having (ordertotal<=5)
