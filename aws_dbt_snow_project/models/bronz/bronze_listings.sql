---select * from {{ source('staging', 'Listings') }}


{{
    config(
        materialized = 'incremental',
       
    )
}}

select * 
from {{ source('staging', 'Listings') }}

{% if is_incremental() %}
 
  where created_at > (select max(created_at) from {{ this }})

{% endif %}