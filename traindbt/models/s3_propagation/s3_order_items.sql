{{  config( alias =  this.name + var('var_pno') ) }}


with

source as (

    select * from {{ source('ecom','s1_order_items') }}
    -- if you generate a larger dataset, you can limit the timespan to the current time with the following line
    -- where ordered_at >= '{{ var("var_ordered_after") }}'
),

renamed as (

    select

        ----------  ids
        id as order_item_id,
        order_id,
        sku as product_id

    from source

)

select * from renamed
