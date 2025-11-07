with 
customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (
    select * from {{ ref('stg_orders') }}
), 

order_itmes as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
),
-- add location info

setup as (
    select
        ord.order_id
        , cus.customer_id
        , p.product_id
        , p.product_price
        , 1 AS order_count
        , ord.ordered_at
    from orders as ord
    join customers  cus
        on ord.customer_id = cus.customer_id
    join order_items as oi
        on ord.order_id = oi.order_id
    join products as p
        on oi.product_id = p.product_id
)

select
*
from setup

-- write a query to get the subtotal by order_id
-- also include # of items in the order
