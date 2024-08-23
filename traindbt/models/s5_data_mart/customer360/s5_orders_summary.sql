{{  config( alias =  this.name + var('var_pno') ) }}

select * from {{ ref('customer_summary')}}
