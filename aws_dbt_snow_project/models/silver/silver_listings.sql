select
    *,
    {{ flag('price_per_night') }} as flag
from {{ ref('bronze_listings') }}
