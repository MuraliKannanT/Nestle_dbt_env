
{% snapshot s5_products_scd_000 %}

{{
    config(
      target_database='dbt_training',
      target_schema='BUS',
      unique_key='product_id',
      strategy='timestamp',
      updated_at='updated_ts',
    )
}}

select * from {{ ref('s3_products') }}

{% endsnapshot %}