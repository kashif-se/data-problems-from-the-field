-- One row per order.
-- Category added so the dashboard can filter revenue by product category.

select
    o.order_id,
    o.customer_id,
    o.ordered_at,
    date_trunc('month', o.ordered_at) as order_month,
    o.status,
    p.category,
    o.order_total
from {{ ref('stg_orders') }} o
left join {{ ref('stg_order_items') }} i
    on o.order_id = i.order_id
left join {{ ref('stg_products') }} p
    on i.product_id = p.product_id
where o.status = 'completed'
