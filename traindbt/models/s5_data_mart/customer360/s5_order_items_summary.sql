{{  config( alias =  this.name + var('var_pno') ) }}

with

order_items as (

select c.order_id, a.order_item_id, a.product_id, c.order_total, b.product_price, b.is_drink_item, b.is_food_item 
from {{ ref('s3_order_items') }}  a join {{ ref('s3_products') }}  b on a.product_id=b.product_id
join {{ ref('s3_orders') }} c on a.order_id = c.order_id
)

select
    order_id,
    sum(order_total) as order_cost,
    sum(product_price) as order_items_subtotal,
    count(order_item_id) as count_order_items,
    sum(is_food_item) as count_food_items,
    sum(is_drink_item) as count_drink_items

from order_items

group by 1