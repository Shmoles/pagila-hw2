SELECT
    DATE_PART('year', rental_date)::int AS "Year",
    DATE_PART('month', rental_date)::int AS "Month",
    COUNT(*) AS "Total Rentals"
FROM rental
GROUP BY ROLLUP (
    DATE_PART('year', rental_date)::int,
    DATE_PART('month', rental_date)::int
)
ORDER BY 1, 2;
