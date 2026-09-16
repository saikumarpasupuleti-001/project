{% macro cleaner(col) %}
    TRIM(UPPER({{ col }}))
{% endmacro %}

{% macro flag(col) %}
    CASE
        WHEN {{ col }} <= 100 THEN 'low'
        WHEN {{ col }} > 100 AND {{ col }} <= 300 THEN 'medium'
        WHEN {{ col }} > 300 AND {{ col }} <= 500 THEN 'high'
        ELSE 'premium'
    END
{% endmacro %}