SELECT
    DATE_PART('year', r.rental_date)::int AS "Year",
    DATE_PART('month', r.rental_date)::int AS "Month",
    ROUND(SUM(p.amount), 2) AS "Total Revenue"
FROM rental r
JOIN payment p USING (rental_id)
GROUP BY ROLLUP (
    DATE_PART('year', r.rental_date)::int,
    DATE_PART('month', r.rental_date)::int
)
ORDER BY 1, 2;
