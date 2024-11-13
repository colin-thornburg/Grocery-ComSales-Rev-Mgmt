SELECT
    product_id,
    tier_name,
    CAST(base_price AS NUMERIC) as base_price,
    min_quantity,
    max_quantity,
    effective_date
FROM {{ ref('raw_pricing_tiers') }}