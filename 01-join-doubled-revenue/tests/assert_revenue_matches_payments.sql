-- Revenue on the dashboard must match what was actually collected.
-- Payments are matched to orders by order_id and grouped by the order's month.
-- Returns a row for every month where the two disagree.

with collected as (
    select
        date_trunc('month', o.ordered_at) as order_month,
        sum(p.amount) as collected
    from {{ ref('stg_payments') }} p
    join {{ ref('stg_orders') }} o
        on p.order_id = o.order_id
    group by 1
)

select
    r.order_month,
    r.revenue,
    c.collected
from {{ ref('monthly_revenue') }} r
full outer join collected c
    on r.order_month = c.order_month
where coalesce(r.revenue, 0) <> coalesce(c.collected, 0)
