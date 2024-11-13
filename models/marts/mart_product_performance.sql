SELECT
    o.product_id,
    p.tier_name,
    COUNT(DISTINCT o.order_id) as total_orders,
    SUM(o.quantity) as total_quantity,
    SUM(o.total_amount) as total_revenue,
    AVG(d.delivery_delay_minutes) as avg_delivery_delay,
    SUM(d.total_fuel_cost) as total_delivery_cost
FROM {{ ref('int_order_pricing') }} o
LEFT JOIN {{ ref('Supply_Chain_Transportation', 'int_delivery_metrics') }} d
    ON o.delivery_id = d.delivery_id
LEFT JOIN {{ ref('stg_revenue__pricing_tiers') }} p
    ON o.product_id = p.product_id
GROUP BY o.product_id, p.tier_name