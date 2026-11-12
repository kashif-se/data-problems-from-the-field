select
    order_id,
    customer_id,
    ordered_at,
    status,
    order_total
from {{ ref('raw_orders') }}
