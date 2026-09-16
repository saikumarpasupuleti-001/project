{% macro multiply (nights_booked, booking_amount) %}
    {{ nights_booked }} * {{ booking_amount }}
{% endmacro %}

{% macro total_service(cleaning_fee, service_fee) %}
    {{cleaning_fee}} + {{service_fee}}
{% endmacro %}