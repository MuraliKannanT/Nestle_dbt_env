
def model(dbt, session):
    
    dbt.config(materialized = "incremental",
               unique_key = "product_id",
               alias = "s5_products_py_000",
               merge_update_column="product_price")


    df = dbt.ref("s3_products")

    if dbt.is_incremental:
        max_date = f"select max(updated_ts) from {dbt.this}"
        df = df.filter(df.updated_ts >= session.sql(max_date).collect()[0][0])

    return df