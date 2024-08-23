import snowflake.snowpark.functions as F
def model(dbt, session):
    dbt.config(materialized="table",alias="s3_products_py_000")
    df = dbt.source("ecom","s1_products")
    df = df.with_column("price",df["price"]/100)
    df = df.with_column("is_food_item",F.iff(F.col("type")=="jaffle",F.lit(1),F.lit(0)))
    df = df.with_column("is_drink_item",F.iff(F.col("type")=="beverage",F.lit(1),F.lit(0)))
    df = df.rename({F.col("sku"): "product_id", "name": "product_name","type": "product_type", \
                    "description": "product_description","price": "product_price", \
                        "updated_at": "updated_ts" })
    return df
