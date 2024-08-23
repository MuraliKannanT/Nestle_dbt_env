{{  config( alias =  this.name + var('var_pno') ) }}

with

source as (

    select * from  {{ source('ecom', 's1_products') }} 

),

renamed as (

    select

        ----------  ids
        sku as product_id,

        ---------- text
        name as product_name,
        type as product_type,
        description as product_description,


    
        ---------- numerics
        (price / 100.0) as product_price,

        ---------- booleans
        case
            when type = 'jaffle' then 1
            else 0
        end as is_food_item,

        case
            when type = 'beverage' then 1
            else 0
        end as is_drink_item,

        ---------- timestamp
        updated_at as updated_ts

    from source

)

select * from renamed


