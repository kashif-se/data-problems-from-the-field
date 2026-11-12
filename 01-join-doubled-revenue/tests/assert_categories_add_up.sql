-- Revenue split by category must add up to the monthly total.

with by_category as (
    select order_month, sum(revenue) as revenue
    from {{ ref('revenue_by_category') }}
    group by 1
)

select
    m.order_month,
    m.revenue as monthly_total,
    c.revenue as category_total
from {{ ref('monthly_revenue') }} m
left join by_category c
    on m.order_month = c.order_month
where c.revenue is null or m.revenue <> c.revenue
