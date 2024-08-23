{% macro testing(db,sc,dm,ft,pk,fk) -%}

{# setting the variable values from the input paramters #}

{% set dimname = db.upper() + '.' + sc.upper() + '.' + dm.upper() %}
{% set schname = db.upper() + '.' + sc.upper() %}

{% set primkey = pk.upper() %}
{% set forekey = fk.upper() %}


{% set check_query %}
select to_boolean(count(1)) as col1 from information_schema.tables 
where table_catalog = '{{db.upper()}}' and table_schema = '{{sc.upper()}}' 
 and table_name in ('{{dm.upper()}}','{{ft.upper()}}') 
{% endset %}

{% if execute %}
    {% set chkresult =  run_query(check_query) %}
    {% set table_exists = chkresult.columns[0].values()[0] %}
{% endif %}

{% set primary_query %}
show imported keys in schema {{ schname }}
{% endset %}

{# Get the Query ID of the Show query #}

{% set prim = run_query(primary_query) %}

{% set lquery %}
select last_query_id() 
{% endset %}

{% set lqid = run_query(lquery) %}

{% if execute %}
    {% set qid = lqid.columns[0].values()[0] %}
    {% set info_query %}
        select "pk_column_name", "fk_column_name", "fk_table_name" from table(result_scan('{{qid}}')) 
        where "pk_database_name" = '{{ db.upper() }}' and
        "pk_schema_name" = '{{ sc.upper() }}' and
        "pk_table_name" = '{{ dm.upper() }}'
        and "fk_table_name" like 'S5_F%';
    {% endset %}

    {% set colnames = run_query(info_query) %}
    {% set pk_col = colnames.columns[0].values()[0] %}
    {% set fk_col = colnames.columns[1].values()[0] %}
    {% set fk_tab = colnames.columns[2].values()[0] %}
    {% set fctname = db.upper() + '.' + sc.upper() + '.' + fk_tab.upper() %}

    {# { exceptions.raise_compiler_error(fk_col)} #} 

{% endif %}

{% if table_exists == 'False' %}

    {{ exceptions.raise_compiler_error(table_exists)}} 

{% else %}
    {# Insert the inferred record with the Surrogte Key value into the dimension #}

{% set insert_query %}
INSERT INTO {{ dimname }} ({{pk_col}},inferred_flag) 
SELECT DISTINCT factable.{{fk_col}}, TRUE 
FROM {{ fctname }} AS factable 
LEFT OUTER JOIN {{ dimname }} AS dimtable 
ON factable.{{fk_col}} = dimtable.{{pk_col}} 
WHERE dimtable.{{pk_col}} IS NULL
{% endset %}

    {% if execute %}
        {% do run_query(insert_query) %}
    {% endif %}

{% endif %}

{%- endmacro %}

