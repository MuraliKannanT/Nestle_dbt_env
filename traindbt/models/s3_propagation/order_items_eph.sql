{{ 
    config(materialized='ephemeral')
}}
select c.order_id, a.order_item_id, a.product_id, c.order_total, b.product_price, b.is_drink_item, b.is_food_item 
from {{ ref('s3_order_items') }}  a join {{ ref('s3_products') }}  b on a.product_id=b.product_id
join {{ ref('s3_orders') }} c on a.order_id = c.order_id

