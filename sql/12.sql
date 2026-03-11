SELECT bts.title
FROM (
    SELECT DISTINCT title
    FROM film
    CROSS JOIN LATERAL UNNEST(special_features) AS u(special_feature)
    WHERE u.special_feature = 'Behind the Scenes'
) bts
JOIN (
    SELECT DISTINCT title
    FROM film
    CROSS JOIN LATERAL UNNEST(special_features) AS u(special_feature)
    WHERE u.special_feature = 'Trailers'
) tr USING (title)
ORDER BY bts.title;
