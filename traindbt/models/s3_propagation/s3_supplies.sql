{{  config( alias =  this.name + var('var_pno') ) }}




with

source as (
    select * from {{ source('ecom', 's1_supplies') }} 

),

renamed as (

    select

        ----------  ids
        
        md5(concat(coalesce(id,'0'),'|',coalesce(sku,'_EMPTY'))) as supply_uuid,
        id as supply_id,
        sku as product_id,

        ---------- text
        name as supply_name,

        ---------- numerics
        (cost / 100.0) as supply_cost,

        ---------- booleans
        perishable as is_perishable_supply

    from source

)

select * from renamed
