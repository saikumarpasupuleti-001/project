{{
    config(
        materialized = 'table',
        schema       = 'GOLD'
    )
}}

{#
  One Big Table (OBT) — Gold Layer
  ─────────────────────────────────────────────────────────
  This model is fully config-driven. All join logic lives in
  dbt_project.yml under vars.obt_config.

  To change which tables are joined or what the join keys are:
    → Edit vars.obt_config in dbt_project.yml
    → Re-run: dbt run --select obt
  ─────────────────────────────────────────────────────────
#}

{{ generate_obt(var('obt_config')) }}
