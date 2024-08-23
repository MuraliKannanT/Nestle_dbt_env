{{  config( alias =  this.name + var('var_pno') ) }}

with

source as (
    select * from {{ source('ecom','s1_orders')}}
    where order_total != 0

    -- if you generate a larger dataset, you can limit the timespan to the current time with the following line
    -- and ordered_at >= '{{ var("var_ordered_after") }}'

),

renamed as (

    select

        ----------  ids
        id as order_id,
        store_id as location_id,
        customer as customer_id,

        ---------- numerics
        (order_total / 100.0) as order_total,
        (tax_paid / 100.0) as tax_paid,

        ---------- timestamps
        ordered_at

    from source

)

select * from renamed

