select
    payment_id,
    order_id,
    paid_at,
    amount
from {{ ref('raw_payments') }}
