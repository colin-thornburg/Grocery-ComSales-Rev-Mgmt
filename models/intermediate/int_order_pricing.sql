SELECT
    o.order_id,
    o.delivery_id,
    o.customer_id,
    o.product_id,
    o.quantity,
    o.unit_price,
    o.total_amount,
    p.tier_name,
    p.base_price,
    CASE 
        WHEN o.unit_price < p.base_price THEN 'Discounted'
        WHEN o.unit_price = p.base_price THEN 'Standard'
        ELSE 'Premium'
    END as pricing_type
FROM {{ ref('Commercial_Sales_Ordering', 'stg_ordering__orders') }} o
LEFT JOIN {{ ref('stg_revenue__pricing_tiers') }} p
    ON o.product_id = p.product_id
    AND o.quantity BETWEEN p.min_quantity AND p.max_quantity