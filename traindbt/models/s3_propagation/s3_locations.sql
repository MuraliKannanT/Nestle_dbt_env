{{  config(alias =  this.name + var('var_pno') ) }}


with

source as (

    select * from {{ ref('raw_stores') }} 
        

),

renamed as (

    select

        ----------  ids
        id as location_id,

        ---------- text
        name as location_name,

        ---------- numerics
        tax_rate,

        ---------- timestamps
        {{dbt.date_trunc('day', 'opened_at')}} as opened_at

    from source

)

select * from renamed
