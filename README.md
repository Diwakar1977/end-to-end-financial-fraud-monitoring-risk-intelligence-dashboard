# End-to-End-Financial-Fraud-Monitoring-Risk-Intelligence-Dashboard
A Scalable fraud analytics solution built on 5M+ transaction to enable real-time monitoring, behavioral risk scoring and investigation-level insights  
# Project Overview 
The financial fraud monitoring & risk intelligence dashboard is designed to analyze large scale financial transaction and identify fraudulent phatterns.The dashboard provides real-time insights into fraud treands high-risk accounts,merchant categories and transaction begaviors.
Using interactive visulizations,the dashboard helps analyst detect suspicious activity,moniter fraud risk,and support data driven decision-making.
# Key Goals
* Monitor fraud vs non-fraud transactions
* Identify high-risk merchant categories
* Detect suspicious accounts
* Track fradu trends over time
* Analyze transactions patterns across regions and hours
# Business Problem
Financial instittions process millons of transaction daily,makig it difficult to manually detect fraudulent acitivity.
# The keys challenges include 
* Identifying fraudulent transactions in large datasets
* Detecting high-risk merchant categories
* Monitoring fraud activity across time and regions
* Identifying suspicious accounts with abnormal transaction behavior
The dashboards helps fraud analysis quickly detect patterns and investigate anomalies.
# Dataset Details
Dataset Name : Financial Fraud Transactions
Total Records : 5 Million Transactions
# Key fields
Column                         Description
transaction_id        -     Unique ID every transaction
timestamp             -     date and time transaction
sender_account        -     account initiating the transaction 
receiver_account      -     account number of the person receiving money
amount                -     transactions value
transaction_type      -     type of payment method
merchant_category     -     merchant business category
location              -     transaction location
device_used           -     device used to perform the transaction
is_fraud              -     fraud indicator(0 : non-fraud,1 : fraud)
spending_deviation_score -  detect abnormal purchase patterns 
velocity_score        -     risk score based on transaction frequency
geo_amomaly_score     -     detect location based fraud
payment_channel       -     payment method(UPI,Card,ACH,Wire)
ip_address            -     used during the transaction  
device_hash           -     unique encrypted identifier for the user's device

