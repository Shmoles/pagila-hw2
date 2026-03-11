SELECT a.last_name, a.first_name
FROM actor a
LEFT JOIN customer c
  ON a.first_name = c.first_name
 AND a.last_name = c.last_name
WHERE c.customer_id IS NULL
ORDER BY a.last_name, a.first_name;
