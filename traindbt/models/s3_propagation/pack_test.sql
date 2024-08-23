{{  config(alias =  this.name + var('var_pno') ) }}

select {{ dbt_utils.surrogate_key(['order_item_id','order_id']) }} as_order_item_key, order_item_id, order_id, product_id 
from {{ ref('s3_order_items')}}
