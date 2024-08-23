{{  config(alias =  this.name + var('var_pno'), materialized = 'view' ) }}

with

source as (
    select * from {{ source('ecom','s1_customers') }}

),

renamed as (

    select

        ----------  ids
        id as customer_id,

        ---------- text
        name as customer_name

    from source

)

select * from renamed
