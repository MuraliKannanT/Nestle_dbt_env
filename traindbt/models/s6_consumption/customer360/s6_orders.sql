{{     config(alias=this.name + var('var_pno') ) }}

select * from 
{{ ref('s5_orders')}}