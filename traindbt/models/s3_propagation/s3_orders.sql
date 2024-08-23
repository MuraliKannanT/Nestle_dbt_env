{{  config( alias =  this.name + var('var_pno') ) }}

with

source as (
    select * from dbt_training.stg.s1_orders
    where order_total != 0
    -- if you generate a larger dataset, you can limit the timespan to the current time with the following line
    -- where ordered_at >= '{{ var("var_ordered_after") }}'

),

renamed as (

    select

        ----------  ids
        id as order_id,
        store_id as location_id,
        customer as customer_id,

        ---------- numerics
        (order_total / 100.0) as order_total,
        ({{ dol_eur('order_total',2)}}/100)::number(8,2) order_total_eur,
        {{ dol_inr('order_total',2)}}/100 order_total_inr,
        (tax_paid / 100.0) as tax_paid,

        ---------- timestamps
        ordered_at

    from source

)

select * from renamed
