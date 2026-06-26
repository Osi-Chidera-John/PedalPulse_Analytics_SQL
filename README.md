# 🚴‍♂️ PedalPulse Analytics

### A Deep-Dive MySQL Business Intelligence Project

---

## 📌 Project Overview

PedalPulse Analytics is a **MySQL data analysis project** focused on transforming raw sales data from Kaggle with over 16,000+ rows into clear, actionable business insights

The project analyzes a cycling retail dataset (2013–2016) to uncover:

* Revenue and profit trends
* Customer behavior
* Product performance
* Regional dominance

It is built to showcase **real-world data analytics skills** — not just querying data, but **thinking like a business analyst**.

---

## 🎯 Business Questions Answered

* Which products drive the most revenue and profit?
* Which countries and regions perform best?
* How has the business grown year-over-year?
* Who are the most valuable customers?
* Are there seasonal patterns affecting sales?

---

## 🛠️ Tools & Skills Demonstrated

* **MySQL (Core Analysis)**
* **Excel (Dashboard & Visualization)**
* Data Cleaning & Transformation
* Aggregations
* Window Functions
* Business Insight Generation

---

## 📊 Key Metrics 

* **Total Revenue:** $2,194,468
* **Total Profit:** $1,273,182
* **Profit Margin:** **58%**

➡️ Indicates a **highly profitable and well-managed business model**

---

## 📈 Dashboard Insights

#### Query
```sql
SELECT 
   Product, 
   SUM(Revenue) AS Total_Revenue, 
   SUM(Profit) AS Total_Profit
FROM sales1
GROUP BY
   Product
ORDER BY 1 DESC;
```
| Product                     | Total Revenue | Total Profit |
|----------------------------|--------------:|-------------:|
| Water Bottle - 30 oz.      | 700,706       | 392,614      |
| Road Bottle Cage           | 305,061       | 191,637      |
| Mountain Bottle Cage       | 328,071       | 183,255      |
| Hitch Rack - 4-Bike        | 519,211       | 305,326      |
| All-Purpose Bike Stand     | 341,419       | 200,350      |


* **Top Product:** Water Bottle – 30 oz
* Consistently ranks #1 across all years and age groups
* High-volume driver of revenue

➡️ Supported by strong accessory sales (bike racks, stands) that boost profit margins

---

### 🌍 Country Performance

```sql
SELECT
  Country, 
  SUM(Revenue) AS Total_Revenue, 
  SUM(Profit) AS Total_Profit
FROM sales1
GROUP BY 
  Country
ORDER BY 2 DESC;
```

| Country | Total Revenue | Total Profit |
|----------|-------------:|------------:|
| United States | 830,434 | 480,613 |
| Australia | 389,332 | 214,728 |
| Canada | 325,817 | 199,669 |
| United Kingdom | 247,835 | 149,586 |
| Germany | 219,096 | 127,303 |
| France | 181,954 | 101,283 |


* **Top Market:** United States
* **Key Region:** California (~60% of US revenue)
* Other strong markets: Australia, Canada

➡️ Revenue is concentrated — creating both strength and expansion opportunity

---

### 📉 Year-over-Year (YoY) Performance

```sql
SELECT *, 
  Total_Revenue - Previos_Year AS YoY_Increase,
  ROUND(((Total_Revenue - Previos_Year)/Previos_Year)*100,2) AS YoY_Percentage
FROM(
  SELECT YEAR(`date`) AS `Year`, SUM(Revenue) AS Total_Revenue,
  LAG(SUM(Revenue),1,0) OVER(ORDER BY YEAR(`date`)) AS Previos_Year
  FROM sales1
  GROUP BY `Year`) AS X;
```



### 📊 Excel Dashboard
📸 *![Dashboard](YoY_dashboard.png)*

* **2014:** +31.31% growth
* **2015:** -26.62% decline
* **2016:** +30.44% recovery

➡️ Business shows **high growth potential but noticeable volatility**

---

## 👥 Customer Insights

* **Primary Customers:** Adults (35–64) → Major revenue drivers
* **Secondary:** Young Adults (25–34)
* **Low Engagement:** Seniors (64+)

➡️ Core audience = **active, working-age consumers**

---

## 🗓️ Sales Patterns

* **Peak Period:** May–June (pre-summer demand)
* **Holiday Boost:** December
* **Lowest Month:** July

➡️ Customers buy **before peak usage season**, not during it

---

## ⚠️ Key Business Observations

* Heavy dependence on **California market**
* Sharp **2015 performance drop** needs investigation
* Weak sales in **mid-summer (July)**
* Untapped markets in other US regions

---

## 🚀 Recommendations

* **Inventory Planning:** Stock up before May/June surge
* **Marketing:** Run mid-year campaigns to fix July slump
* **Expansion:** Target underperforming US states
* **Risk Control:** Analyze and prevent future downturns

---
## 🔗 Project Link

Explore the full project, SQL queries here: [Open Work](https://github.com/Osi-Chidera-John/PedalPulse_Analytics_SQL/blob/main/queries.sql)

---

## 📸 Dashboard Section

This project includes Excel dashboards for quick visual understanding:

* Product Performance Dashboard
* Country Performance Dashboard
* Year-over-Year Growth Dashboard

---

## 🤝 Contact

* **Email:** chiderajohn519@gmail.com
* **LinkedIn:** https://www.linkedin.com/in/john-chidera-jr-0b6b55319/

---

## ⭐ Final Note

This project demonstrates the ability to:

* Work with real datasets
* Extract meaningful insights
* Communicate findings clearly

It reflects readiness for **data analyst roles** where business impact matters.

---

