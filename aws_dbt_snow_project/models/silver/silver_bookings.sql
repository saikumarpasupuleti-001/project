
  select  booking_id,Listing_id ,booking_date ,booking_status, created_at,
  {{multiply('nights_booked' , 'booking_amount')}} as booking_total_amount
  , {{total_service('cleaning_fee' , 'service_fee')}} as total_service_fee 
   from {{ ref('bronze_bookings') }}

