




--select * from bookings where created_at > (select max(created_at)from bookings)

---select * from   {{source('staging', 'Bookings')}}


{{
    config(
        materialized = 'incremental',
       
    )
}}

select * 
from {{ source('staging', 'Bookings') }}

{% if is_incremental() %}

  where created_at > (select max(created_at) from {{ this }})

{% endif %}
