# Retail Sales Data Quality & Business Analysis

An end-to-end retail sales analytics project focused on **data quality, validation, business analysis, profitability, and reporting** using Excel, Power Query, MySQL, and Power BI.

## Project Overview

This project analyzes a 200-record retail sales dataset from data validation through business reporting.

The objective was to:

- Validate the reliability and consistency of the source data
- Identify customer and transaction-level data-quality issues
- Build a repeatable Excel reporting workflow
- Analyze sales, profit, margins, customers, products, categories, and regions
- Create interactive dashboards for business reporting
- Translate analytical findings into actionable areas for investigation

---

## Business Questions

The analysis focused on questions such as:

1. Is the dataset reliable enough for business analysis?
2. Are there inconsistencies in customer and transaction data?
3. Which regions and categories generate the most sales and profit?
4. Which products have weak or negative profitability?
5. How many customers are repeat versus one-time customers?
6. How do sales change over time?
7. Can the reporting workflow be made more repeatable and less manual?

---

## Data Quality Analysis

The dataset contained **200 transaction records**.

### Validation Results

- **8/8 core data-quality checks passed**
- **85 unique Customer IDs**
- **199 unique customer names**
- **61 of 85 Customer IDs (71.76%)** were associated with multiple customer names

The customer-name inconsistency was flagged for investigation rather than manually corrected because the available data did not provide enough evidence to determine the authoritative customer identity.

This demonstrates the importance of separating **data-quality detection** from unsupported data correction.

---

## Excel & Power Query Workflow

Power Query was used to clean and standardize the source dataset before analysis.

An Excel **Operations Summary** was then developed using:

- XLOOKUP
- SUMIFS
- PivotTables
- Data validation
- Reconciliation checks
- Dashboard reporting

The product-level summary combined:

**Product ID → Product Name → Quantity → Sales → Profit → Margin**

### Reconciliation

The summarized reporting was reconciled back to the original transaction-level dataset.

| Check | Difference |
|---|---:|
| Sales | 0 |
| Quantity | 0 |

This provided a control that the summarized reporting tied back to the source data.

---

## SQL Analysis

MySQL was used for:

- Data-quality validation
- Customer consistency analysis
- Regional analysis
- Category analysis
- Product profitability analysis
- Customer behavior analysis
- Monthly sales analysis
- KPI calculations

---

## Key Business Metrics

| Metric | Result |
|---|---:|
| Total Sales | $206,813.95 |
| Total Profit | $13,042.51 |
| Profit Margin | 6.31% |
| Total Orders | 200 |
| Total Quantity | 1,115 |
| Average Order Value | $1,034.07 |
| Repeat Customers | 61 |
| One-Time Customers | 24 |

---

## Regional Findings

### Sales

| Region | Sales |
|---|---:|
| South | $55,317.47 |
| East | $53,139.57 |
| Central | $52,829.34 |
| West | $45,527.57 |

### Profitability

Central produced the strongest regional profit margin at **11.97%**.

East generated **$53,139.57 in sales** but had the lowest profit margin at **1.81%**, making it an important area for further investigation.

---

## Product & Category Findings

The analysis drilled from regional performance into category and product-level profitability.

One notable finding was **Technology in the East region**, where profitability was negative.

**Accessories Product 13** was also identified as a significant loss contributor:

- Sales: **$3,561.53**
- Profit: **-$325.48**

These findings were treated as investigation points rather than assumptions about the underlying cause.

---

## Customer Data Quality

A customer consistency analysis identified:

- **85 unique Customer IDs**
- **199 unique customer names**
- **61 Customer IDs with multiple associated names**

Example:

`CUST-103` appeared with five different customer names across different segments and regions.

This demonstrates how a technically valid Customer ID can still contain a significant **master-data consistency problem**.

---

## Customer Behavior

The analysis classified customers based on purchasing activity:

- **61 repeat customers**
- **24 one-time customers**

This provides a starting point for future customer-retention and customer-value analysis.

---

## Dashboards

### Excel Dashboard

The Excel dashboard provides:

- Total Sales
- Total Profit
- Profit Margin
- Average Order Value
- Total Orders
- Total Quantity
- Regional performance
- Category mix
- Segment mix
- Monthly sales trends

### Power BI Dashboard

The Power BI dashboard provides interactive reporting for:

- Sales
- Profit
- Profitability
- Orders
- Quantity
- Regional performance
- Category performance
- Segment performance
- Monthly trends

---

## Tools & Technologies

**Excel**
- Power Query
- XLOOKUP
- SUMIFS
- PivotTables
- Data Validation
- Reconciliation
- Dashboard Development

**SQL / MySQL**
- Data Quality Checks
- Aggregations
- GROUP BY
- Customer Analysis
- Profitability Analysis
- Trend Analysis

**Power BI**
- KPI Cards
- Interactive Filters
- Data Visualization
- Dashboard Development
- Business Performance Reporting

---

## Project Workflow

```text
Raw Dataset
     ↓
Data Quality Validation
     ↓
Power Query Cleaning
     ↓
SQL Analysis
     ↓
Excel Operations Summary
     ↓
Reconciliation
     ↓
Business Analysis
     ↓
Excel Dashboard
     ↓
Power BI Dashboard
     ↓
Business Findings
