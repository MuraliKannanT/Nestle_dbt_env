{% macro dol_eur(colm, deci) -%}
    round( 0.96 * {{ colm }}, {{ deci }})
{%- endmacro %}


{% macro dol_inr(colm, deci) -%}
    round( 83.30 * {{ colm }}, {{ deci }})
{%- endmacro %}
