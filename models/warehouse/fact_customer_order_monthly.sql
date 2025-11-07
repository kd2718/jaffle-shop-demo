
with fo as (
    select * from {{ ref('fact_orders') }}
)
, dc as (
    select * from {{ ref('dim_customer') }}
)

, setup as (
        select
            dc.customer_id
            , YEAR(fo.ordered_at) as order_year
            , MONTH(fo.ordered_at) as order_month
            , fo.order_count
        from dc
        left join fo
            on dc.customer_id = fo.customer_id
)

select
    customer_id
    , order_year
    , order_month
    , sum(order_count) as monthly_order_count
from setup
group by customer_id, order_year, order_month

-- BUG: we don't know who didn't order anything in that month!
