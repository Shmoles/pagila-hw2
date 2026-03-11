SELECT special_feature AS special_features, COUNT(*) AS count
FROM (
    SELECT UNNEST(special_features) AS special_feature
    FROM film
) x
GROUP BY special_feature
ORDER BY special_feature;
