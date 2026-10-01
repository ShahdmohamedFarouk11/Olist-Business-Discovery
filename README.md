# 🛒 Olist Business Discovery

A data-driven business discovery project based on the **Brazilian E-Commerce Public Dataset by Olist**.

The goal of this project is to understand the business through data, discover key patterns and challenges, and turn the findings into a possible **Data & AI solution**.

> 📌 The analysis is based on historical Olist data from **2016–2018**.

---

## 🔎 Project Approach

**Dataset Research → Python EDA & Cleaning → SQL Analysis → Business Analysis → Business Insights → Data & AI Solution**

### 🏢 Company & Dataset Research
- Researched Olist and its e-commerce ecosystem
- Explored the dataset structure and business context
- Identified the main entities and relationships

### 🐍 Python EDA & Cleaning
Used Python to explore and prepare the data:
- Dataset structure
- Data types
- Missing values
- Duplicates
- Date formatting
- Data cleaning and preparation

### 🗄️ SQL Analysis
Created a SQL Server database and analyzed the data from a business perspective.

An **ERD** was also created to understand the relationships between the main tables.

The analysis covered:
- Orders & customers
- Order value
- Order status
- Delivery performance
- Late vs. on-time orders
- Customer reviews
- Sellers & products

### 📊 Business Analysis
Returned to Python for deeper analysis and visualization, focusing on:
- Delivery performance
- Late delivery rates
- Sellers
- Customer states
- Customer behavior
- Time patterns
- Review scores

---

## 💡 Key Findings

- **96.9%** of customers placed only one order.
- On-time orders had an average review score of around **4.3**, compared with around **2.6** for late orders.
- Average delivery time was around **12 days**, with a median of around **10 days**.
- Late delivery rates varied across **sellers, customer states, and months**.
- The monthly late delivery rate reached around **18.6%** in April 2018.

These findings highlight delivery performance as an important part of the overall customer experience.

---

## 🚀 Business Story

The analysis showed that delivery performance is not the same across the business.

Late orders have much lower average review scores than on-time orders, while delivery performance also varies between sellers, states, and time periods.

This creates an opportunity to move from simply reacting to delivery problems to identifying **orders that may be at risk of being late before the delay happens**.

---

## 🤖 Proposed Data & AI Solution

### 🎯 Forecasting & Predictive Solutions

The main proposed direction is a predictive model that can identify **orders at risk of late delivery**.

Potential features include:
- Seller delivery performance
- Seller late delivery rate
- Customer state
- Order value
- Freight value
- Number of items

A **Random Forest Classifier** is planned as the first model:

```text
1 → Late
0 → On Time
```

### 🚚 Logistics Intelligence
Helps understand where delivery problems are concentrated across sellers, locations, and time periods.

### 📈 Analytics & Decision Systems
Helps monitor delivery KPIs and support better business decisions.

---
## 📁 Project Structure

```
Olist-Business-Discovery/
│
├── Olist_DataAnalysis&Ml.ipynb
├── olist_queries.sql
├── olist_erd.jpeg
├── olist
│
└── dataset/
    ├── geolocation_clean.csv
    ├── items_clean.csv
    ├── orders_clean.csv
    ├── reviews_clean.csv
    ├── olist_customers_dataset.csv
    ├── olist_geolocation_dataset.csv
    ├── olist_order_items_dataset.csv
    ├── olist_order_payments_dataset.csv
    ├── olist_order_reviews_dataset.csv
    ├── olist_orders_dataset.csv
    ├── olist_products_dataset.csv
    ├── olist_sellers_dataset.csv
    └── product_category_name_translation.csv
```

## 🛠️ Tools & Technologies

- Python
- Pandas
- NumPy
- Matplotlib
- SQL Server
- SQL
- Jupyter Notebook
- Git & GitHub

---

## 📦 Dataset

**Brazilian E-Commerce Public Dataset by Olist**

The dataset contains approximately 100,000 orders from 2016 to 2018, including information about:

`Customers` · `Orders` · `Products` · `Sellers` · `Payments` · `Reviews` · `Delivery`

---

## 🎯 Project Outcome

The goal was to move from:

**Data → Insights → Business Problems → Solution Direction**

with a focus on using predictive analytics and logistics intelligence to better understand and anticipate delivery risks.
