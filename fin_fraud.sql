-- Database name
use july;

-- financial fraud sample data
create table fin_fraud select * from financial_fraud limit 20000;

-- View all data
select * from fin_fraud;

-- select specific columns
select transaction_id,amount,is_fraud from fin_fraud;

-- Filter only fraud transactions
select transaction_id,amount from fin_fraud where is_fraud = 1;

-- High amount transactions
select transaction_id,amount from fin_fraud where amount > 2000;

-- Total transactions 
select count(*) as total_tnx from fin_fraud;

-- Total fraud transactons
select count(*) as fraud_count from fin_fraud where is_fraud = 1;

-- Fraud rate %
select round(sum(is_fraud) / count(*) * 100,2) as fraud_rate from fin_fraud;

-- Total fraud aamount 
select round(sum(amount),2) as fraud_amount from fin_fraud;

-- Fraud count by transaction 
select transaction_type,count(*) as fraud_count from fin_fraud where is_fraud = 1 group by transaction_type;

-- Fraud by location
select location,sum(is_fraud) as fraud_count from fin_fraud group by location;

-- Fraud counts by merchant category
select merchant_category,
	count(transaction_id) as total_tnx,
	sum(case when is_fraud = 0 then 1 else 0 end) as non_fraud_tnx,
    sum(case when is_fraud = 1 then 1 else 0 end) as fraud_tnx
from fin_fraud group by merchant_category;

-- Transactions greater than avg amount
select * from fin_fraud where amount > (select avg(amount) from fin_fraud);

-- Accounts involved in fraud more than 3 times
select sender_account from fin_fraud where is_fraud = 1 group by sender_account having count(*) >= 3;

-- Transaction with amount higher than fraud avg
select * from fin_fraud where amount > (select avg(amount) from fin_fraud where is_fraud = 1);

-- 
select transaction_id,sender_account,amount,row_number() over (order by amount desc) as row_num from fin_fraud;

-- Rank transaction by amount(highest first)
select transaction_id,sender_account,amount from
(select transaction_id,sender_account,amount,is_fraud,row_number() over (order by amount desc) as rn from fin_fraud) t
where rn = 1;

-- Running total by timestamp 
select transaction_id,sender_account,amount,
	round(sum(amount) over (order by `timestamp`),2) as running_total 
from fin_fraud;

-- Moving average by timestamp 
select transaction_id,sender_account,amount,
	round(avg(amount) over (order by `timestamp`),2) as moving_avg 
from fin_fraud;


-- Highest value
select * from fin_fraud order by amount desc limit 1 offset 1;

-- second highest value
select * 
	from (select *,row_number() over (order by amount desc) as rn from fin_fraud) t 
where rn = 2;

-- Fraud percentage per location
select location,
	count(transaction_id) as total_tnx,
    sum(is_fraud) as fradu_tnx,
    round(sum(is_fraud) / count(*),2) as fraud_rate,
    round(sum(is_fraud) / sum(count(*)) over() * 100,2) as contribution_total_fraud 
from fin_fraud group by location;

-- last 10 mins transactions 
select sender_account,
	`timestamp`,
    count(*) over (partition by sender_account order by `timestamp` 
    range between interval 10 minute preceding and current row) tnx_last_10mins 
from fin_fraud;

-- Composite index
create index idx_name on fin_fraud(sender_account,`timestamp`);

-- Top 10 risk accounts 
select
	sender_account,
    count(*) as fraud_count
from fin_fraud
where is_fraud = 1
group by sender_account
order by fraud_count desc
limit 10; 

-- Geo anomaly detection
select * from fin_fraud where geo_anomaly_score > 0.7;

-- High spending deviation and high velocity score
select * from fin_fraud where geo_anomaly_score > 0.7 and velocity_score > 15;

-- Suspicious IP addresses
select 
	ip_address,
    count(*) as fraud_count
from fin_fraud
where is_fraud = 1 
group by ip_address order by fraud_count desc;

-- Second highest transaction amount
select distinct amount from fin_fraud order by amount desc limit 1 offset 1;

-- Detect duplicate device usage 
select
	device_hash,
    count(distinct sender_account) as user_account
from fin_fraud
group by device_hash order by user_account desc;

-- Month wise fraud rate
select 
	date_format(`timestamp`,'%Y-%M') as `year_month`,
    count(*) as total_tnx,
    sum(is_fraud) as fraud_tnx,
    round(sum(is_fraud) / count(*) * 100,2) as fraud_rate
from fin_fraud
group by `year_month`
order by `year_month`;

-- Fraud rate per payment channel 
select payment_channel,
    count(*) as total_tnx,
    sum(is_fraud) as fraud_tnx,
    round(sum(is_fraud) / count(*) * 100,2) as fraud_rate 
from fin_fraud 
group by payment_channel;

-- Top 5 locations with highest fraud 
select location,
    round(sum(is_fraud) / count(*) * 100,2) as fraud_rate 
from fin_fraud 
group by location
limit 5;

-- Merchant categories contributing 80% fraud 
select merchant_category,
    sum(is_fraud) as fraud_count,
    sum(sum(is_fraud)) over (order by sum(is_fraud) desc) / sum(sum(is_fraud)) over() cumulative_ratio 
from fin_fraud 
group by merchant_category;

-- Average fraud amount vs non-fraud amount
select is_fraud,
	round(avg(amount),2) as avg_amount 
from fin_fraud 
group by is_fraud;

-- Dectect 2 consecutive fraud transactions 
select * 
from (
	select *,
		sum(is_fraud) over (partition by sender_account order by `timestamp` 
        rows between 2 preceding and current row ) fraud_streak
        from fin_fraud) t
where fraud_streak = 2;

-- Month-over-Month fraud growth
select `year_month`,
	fraud_count,
    lag(fraud_count) over (order by `year_month`) prev_month,
    round((fraud_count - lag(fraud_count) over (order by `year_month`)) /
    lag(fraud_count) over (order by `year_month`) * 100,2) mom_growth
from (
	select 
		date_format(`timestamp`,'%Y-%M') `year_month`,
		sum(is_fraud) fraud_count
from fin_fraud
group by `year_month`) t;

-- Transaction above account average 
select * 
from fin_fraud f 
where amount > (
	select avg(amount) from fin_fraud
    where sender_account = f.sender_account);

-- Accounts with fraud more than overall average fraud 
select sender_account
from fin_fraud
where is_fraud = 1 
group by sender_account
having count(*) > (
	select avg(fraud_count)
    from (
		select sender_account,count(*) as fraud_count
        from fin_fraud
        where is_fraud = 1
        group by sender_account
        ) t
);

-- High risk score transactions 
with risk_score as (
	select *,
		round((spending_deviation_score + velocity_score + geo_anomaly_score) / 3,2) as risk_avg
	from fin_fraud
) select *
from risk_score 
where risk_avg > 0.7;

-- High velocity in 5 minutes
select sender_account,
	`timestamp`,
    count(*) over (partition by sender_account order by `timestamp`
    range between interval 5 minute preceding and current row) txn_5min
from fin_fraud;

-- Transactions far above std deviation
select *
from fin_fraud
where amount > 
	(select avg(amount) + 3 * stddev(amount)
from fin_fraud);

-- Fraud spike detection 
select date(`timestamp`)as tnx_date,
	sum(is_fraud) fraud_count
from fin_fraud
group by tnx_date
order by fraud_count desc;

-- Pivot fraud by transaction type
select 
	sum(case when payment_channel = 'UPI' then is_fraud else 0 end)  as upi_fraud,
    sum(case when  payment_channel = "card" then is_fraud else 0 end) as card_fraud
from fin_fraud;

-- Detect account inactivity the sudden large transaction 
select count(*) as total_count 
from fin_fraud where `timestamp` >= (select max(`timestamp`) from fin_fraud) - interval 1 hour;

-- Fraud counts by last 15 mins
select
	sum(case when is_fraud = 0 then 1 else 0 end) as non_fraud,
    sum(case when is_fraud = 1 then 1 else 0 end ) as fraud
from fin_fraud 
where `timestamp` >= (select max(`timestamp`) from fin_fraud) - interval 15 minute;


