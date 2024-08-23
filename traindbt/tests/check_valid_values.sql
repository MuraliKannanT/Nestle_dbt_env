with customers as (
    select * from {{ ref('s3_customers') }}
)

select * from customers
where trim(customer_id) = '' or trim(customer_name) = ''
