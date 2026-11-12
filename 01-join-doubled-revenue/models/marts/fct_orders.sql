-- Grain: one row per completed order.
-- Don't join order items in here. An order with three items would become three
-- rows, and order_total would be counted three times. Use fct_order_items for
-- anything per product or per category.

select
    order_id,
    customer_id,
    ordered_at,
    date_trunc('month', ordered_at) as order_month,
    order_total
from {{ ref('stg_orders') }}
where status = 'completed'
