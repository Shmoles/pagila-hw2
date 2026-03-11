WITH film_revenue AS (
    SELECT
        f.title,
        COALESCE(SUM(p.amount), 0)::numeric(10,2) AS revenue
    FROM film f
    LEFT JOIN inventory i USING (film_id)
    LEFT JOIN rental r USING (inventory_id)
    LEFT JOIN payment p USING (rental_id)
    GROUP BY f.film_id, f.title
),
revenue_groups AS (
    SELECT
        revenue,
        SUM(revenue) AS group_revenue
    FROM film_revenue
    GROUP BY revenue
),
cumulative_groups AS (
    SELECT
        revenue,
        SUM(group_revenue) OVER (
            ORDER BY revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )::numeric(10,2) AS total_revenue
    FROM revenue_groups
),
ranked AS (
    SELECT
        RANK() OVER (ORDER BY fr.revenue DESC) AS rank,
        fr.title,
        fr.revenue,
        cg.total_revenue
    FROM film_revenue fr
    JOIN cumulative_groups cg
      ON fr.revenue = cg.revenue
)
SELECT
    rank,
    title,
    revenue,
    total_revenue AS "total revenue",
    CASE
        WHEN total_revenue = SUM(revenue) OVER () THEN '100.00'
        ELSE LPAD(
            TO_CHAR(
                100 * total_revenue / SUM(revenue) OVER (),
                'FM999.00'
            ),
            5,
            '0'
        )
    END AS "percent revenue"
FROM ranked
ORDER BY revenue DESC, title;
