{{  config( alias =  this.name + var('var_pno') ) }}

with

order_items as (

select * from {{ ref('order_items_eph') }} 
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