-- Feeds the category filter on the sales dashboard.

select
    order_month,
    category,
    count(distinct order_id) as orders,
    sum(line_total) as revenue
from {{ ref('fct_order_items') }}
group by order_month, category
order by order_month, category
