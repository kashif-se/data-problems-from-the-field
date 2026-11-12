-- Grain: one row per line on a completed order.
-- Revenue by category comes from here, summing line_total, never order_total.

select
    i.order_item_id,
    i.order_id,
    o.order_month,
    i.product_id,
    p.product_name,
    p.category,
    i.quantity,
    i.unit_price,
    i.line_total
from {{ ref('stg_order_items') }} i
join {{ ref('fct_orders') }} o
    on i.order_id = o.order_id
join {{ ref('stg_products') }} p
    on i.product_id = p.product_id
