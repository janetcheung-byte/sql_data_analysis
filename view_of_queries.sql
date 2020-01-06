CREATE VIEW top_5_merchants AS
select t.id_merchant, count(t.id_merchant), t.amount, m.id, m.name
from transaction t
LEFT JOIN merchants m
ON m.id=t.id_merchant
GROUP BY t.id_merchant, t.amount, m.id, m.name
HAVING t.amount < 2
ORDER BY count desc

CREATE VIEW count_transactions AS
select t.card, t.amount, count(t.amount)
from transaction t
where t.amount < 2.00
GROUP BY t.card, t.amount
ORDER BY count(t.amount) desc;

CREATE VIEW group_by_highest_transactions AS
SELECT t.id, t.date, t.amount, t.card, m.name
FROM transaction t
LEFT JOIN merchants m
ON m.id=t.id_merchant
LEFT JOIN merchant_category c
ON m.id_merchant_category=c.id
GROUP by c.name, t.id, t.date, t.amount, t.card, t.id_merchant, m.id, m.name, m.id_merchant_category, c.name
ORDER BY t.amount;


CREATE VIEW seven_to_nine_am AS
SELECT t.date,
    t.amount,
    t.card,
    m.id_merchant_category,
    c.name
   FROM transaction t
     LEFT JOIN merchants m ON m.id = t.id_merchant
     LEFT JOIN merchant_category c ON m.id_merchant_category = c.id
  WHERE t.date::time without time zone >= '07:00:00'::time without time zone AND t.date::time without time zone <= '09:00:00'::time without time zone
  GROUP BY c.name, t.id, t.date, t.amount, t.card, t.id_merchant, m.id, m.name, m.id_merchant_category
  ORDER BY t.amount DESC
 LIMIT 100;