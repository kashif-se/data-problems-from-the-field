-- Feeds the "Revenue by month" tile on the sales dashboard.

select
    order_month,
    count(*) as orders,
    sum(order_total) as revenue
from {{ ref('fct_orders') }}
group by order_month
order by order_month
