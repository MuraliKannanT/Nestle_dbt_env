{{  config(materialized='incremental', 
           alias =  this.name + var('var_pno'),
           unique_key='order_id') }}


with 

orders as (
    
    select *     from {{ ref('s3_orders')}}
    {% if is_incremental() %}
        where ordered_at > (select max(ordered_at) from {{this}})
    {% endif %}
),

order_items_table as (
    
    select * from {{ ref('s5_order_items')}}

),

order_items_summary as (

    select

        order_items.order_id,

        sum(supply_cost) as order_cost,
        sum(is_food_item) as count_food_items,
        sum(is_drink_item) as count_drink_items


    from order_items_table as order_items

    group by 1

),


compute_booleans as (
    select

        orders.*,
        count_food_items > 0 as is_food_order,
        count_drink_items > 0 as is_drink_order,
        order_cost

    from orders
    
    left join order_items_summary on orders.order_id = order_items_summary.order_id
)

select * from compute_booleans
