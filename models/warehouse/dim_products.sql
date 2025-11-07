
select
    product_id
    , product_name
    , product_price
    , product_type
    , product_description
    -- add a column "food_type"
from {{ ref("stg_products") }}
