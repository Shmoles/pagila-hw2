SELECT title
FROM (
    SELECT title, rating, UNNEST(special_features) AS special_feature
    FROM film
) x
WHERE rating = 'G'
  AND special_feature = 'Trailers'
ORDER BY title;
