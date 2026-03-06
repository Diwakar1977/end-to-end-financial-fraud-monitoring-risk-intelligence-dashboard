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
    # Column and Description
  * transaction_id        -     unique ID every transaction
  * timestamp             -     date and time transaction
  * sender_account        -     account initiating the transaction 
  * receiver_account      -     account number of the person receiving money
  * amount                -     transactions value
  * transaction_type      -     type of payment method
  * merchant_category     -     merchant business category
  * location              -     transaction location
  * device_used           -     device used to perform the transaction
  * is_fraud              -     fraud indicator(0 : non-fraud,1 : fraud)
  * spending_deviation_score -  detect abnormal purchase patterns 
  * velocity_score        -     risk score based on transaction frequency
  * geo_amomaly_score     -     detect location based fraud
  * payment_channel       -     payment method(UPI,Card,ACH,Wire)
  * ip_address            -     used during the transaction  
  * device_hash           -     unique encrypted identifier for the user's device
# Tooltip and Technologies
    # Tool and purpose
* Python(pandas)-data preprocessing
* MySQL-data querying
* Excel-initial analysis
* Power BI-dashboard visulaization
* GitHub-project version control
# Data preparation
    # Data cleaning
* converted timestamp column to datetime format
* remove duplicate transaction
* standardized merchant categories
* handled missing values
      # Feature engineering
* fraud transaction count
* non-fraud transaction count
* fraud rate percentage
* fraud amount
* velocity risk score
* hourly fraud distribution
# Key performance indicator(KPIs)
    # KPI value
* total transaction-5M
* fraud transaction-180k
* fraud rate - 3.59%
* fraud amount - $64.37M
* last 15 mins fraud - real-time fraud monitoring
* last 15 mins non-fraud - real-time legitimate acitvity
* These KPIs allow analysts to quickly understand fraud volume and risk levels.
# Dashboard visulizations 
    # Monthly fraud vs non-fraud trend
  * Chart type : Line chart
* Shows how fraud transaction changes over time and helps identify seasonal fraud pattern.
      # Fraud transaction by region
  * Chart type : Map visualization
* Display fraud transactions geographically to identify high-risk region.
      # Fraud transaction by hour and risk level
  * Chart type : Heatmap
* Shows hourly fraud distribution categorized by risk level.
  * High risk
  * Medium risk
  * Low risk
        # Fraud accounts by amount
  * Chart type: Table
* Identifies accounts responsible for the highest fraud amounts,helping fraud investigation prioritize cases.
      # Fraud amount by velocity score
  * Chart type : Scatter plot
* Analyzes relationship between trasnaction amount and transaction frequency risk score.
      # Fraud vs non-fraud distribution
  * Chart type : Donut chart
* Shows proporation of fraudulent vs legitimate transactions.
# Dashboard filter
The dashboard includes interactive filters.
* Date
* Payment channel
* Merchant category
# Key insights
Analysis of the dataset reveals several important findings.
 * fraud transactions account for 3.59% of total transactions.
 * certain merchant categories show higher fraud concentration.
 * fraud activity varies significantly across regions and hours.
 * accounts with higher velocity scores tend to show higher fraud risk,
 * a small number of accounts contribute to a large portion of fraud amount.
# Conclusion
The financial fraud monitoring dashboard provides a comprehensive view of fraud activity across millions of transactions.By combining advandced analystics and interactive visualizations,the dashboard enables analysts to quickly detect fraud patterns and support effective fraud prevention strategies.

  




      

