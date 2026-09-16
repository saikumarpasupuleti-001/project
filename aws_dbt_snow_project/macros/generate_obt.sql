{#
  generate_obt(config)
  ─────────────────────────────────────────────────────────
  A metadata-driven macro that builds a JOIN query from the
  obt_config variable defined in dbt_project.yml.

  To add/remove a table or change a join key:
    → Edit the vars.obt_config section in dbt_project.yml
    → No changes needed here or in obt.sql
  ─────────────────────────────────────────────────────────
#}

{% macro generate_obt(config) %}

    {%- set base  = config['base'] -%}
    {%- set joins = config['joins'] -%}

    SELECT

        {# ── Base table columns (silver_bookings) ── #}
        {{ base['alias'] }}.BOOKING_ID,
        {{ base['alias'] }}.LISTING_ID,
        {{ base['alias'] }}.BOOKING_DATE,
        {{ base['alias'] }}.BOOKING_STATUS,
        {{ base['alias'] }}.BOOKING_TOTAL_AMOUNT,
        {{ base['alias'] }}.TOTAL_SERVICE_FEE,
        {{ base['alias'] }}.CREATED_AT              AS BOOKING_CREATED_AT,

        {# ── Silver listings columns ── #}
        sl.LISTING_ID                               AS LISTING_KEY,
        sl.PROPERTY_TYPE,
        sl.PRICE_PER_NIGHT,
        sl.FLAG                                     AS PRICE_TIER,

        {# ── Silver hosts columns ── #}
        sh.HOST_ID,
        sh.HOST_NAME,
        sh.HOST_SINCE,
        sh.IS_SUPERHOST,
        sh.RESPONSE_RATE,
        sh.RESPONSE_RATE_QUALITY

    FROM {{ ref(base['model']) }}  AS {{ base['alias'] }}

    {# ── Dynamically build each JOIN from config ── #}
    {% for join in joins %}
    {{ join['join_type'] }} {{ ref(join['model']) }} AS {{ join['alias'] }}
        ON {{ join['left_alias'] }}.{{ join['left_key'] }} = {{ join['alias'] }}.{{ join['right_key'] }}
    {% endfor %}

{% endmacro %}

