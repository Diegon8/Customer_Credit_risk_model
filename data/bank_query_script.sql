/* Finding duplicates in tables application and credit */


SELECT count(distinct(ID)) FROM credit
SELECT count(distinct(ID)) FROM application



/* Finding intersection clients between application and credit tables*/

SELECT a.id,
       AVG(b.months_balance)
FROM application a
LEFT JOIN credit b ON a.id=b.id
WHERE b.months_balance IS NOT NULL
GROUP BY a.id
ORDER BY a.id DESC

/* Return the average annual income from our clients in euros*/

WITH euro AS(
SELECT *,(amt_income_total*0.13) AS euro_income
FROM application)

SELECT  ROUND(AVG(euro_income), 2) 
FROM euro


 /* BIG DF */


WITH clean_status AS(
SELECT * FROM credit
WHERE status NOT IN ('X')
),

risk_table AS(
SELECT id, max(status) AS risk_level FROM clean_status
GROUP BY id
)

SELECT a.*, (a.amt_income_total*0.13) AS euro_income, REPLACE(b.risk_level, 'C', '-1') AS risk_level
FROM application a
LEFT JOIN risk_table b ON a.id=b.id
WHERE b.risk_level IS NOT NULL

 /* Repayment danger level*/

with clean_status as(
select * from credit
where status != 'X'
),

times as(
select id, REPLACE(status, 'C', '-1') as status, count(status) as times_incurred
from clean_status
group by id, status
order by id,status)

select a.id, sum(a.status*a.times_incurred) as pay_danger
from times a
left join application b on a.id = b.id
where b.id is not null
group by id 
order by pay_danger desc