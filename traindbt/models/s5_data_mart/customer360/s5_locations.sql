{{  config( alias =  this.name + var('var_pno') ) }}

select * from {{ ref('s3_locations') }}

