# 🚲 Nantes Mobility – Bicloo Bike Sharing Analysis

**Nantes Mobility** is an open-source data project focused on analyzing the Bicloo public bike-sharing system in the city of Nantes.  
It serves as the foundation for a broader data platform initiative that will grow over time.

📚 This project is designed as a **learning environment** to practice real-world data engineering skills — from ingestion to transformation and visualization.  
🎯 The goal is to build valuable, actionable insights from open urban mobility data, while contributing transparently to the open-source community.

Whether you're a data professional, urban planner, or simply curious about how data can drive smarter cities — this project is open for collaboration, feedback, and evolution. Feel free to reach out if you have questions, ideas, or would like to contribute.

---

## Objectives

- Ingest live data from Bicloo stations in Nantes (status, location, availability)
- Transform and model the data using **dbt**
- Visualize insights with **Power BI** dashboards
- Build a foundation to analyze and share key mobility KPIs

---

## 🧱 Tech Stack

| Step           | Tools Used                                |
| -------------- | ----------------------------------------- |
| Ingestion      | Python + GitHub Actions (hourly schedule) |
| Data Warehouse | Snowflake                                 |
| Transformation | dbt (daily scheduled models)              |
| Orchestration  | GitHub Actions                            |
| Visualization  | Power BI                                  |

---

## Data Workflow

### Ingestion (Hourly)

- A GitHub Action triggers a Python script every hour.
- Data is fetched from Nantes' open data API (Bicloo stations).
- Stored in Snowflake in a `raw` schema.

link to the integration repo : https://github.com/lucaszub/integration-mobility-nantes

### Transformation (Daily)

- dbt models process raw data into:
  - `dim_station`
  - `dim_date`
  - `fact_station_hourly_usage`
- Exposes a clear star schema to Power BI.

---

## dbt Project Structure

```bash
lucaszub-nantes-mobility-dbt/
├── dbt_project.yml
├── models/
│ ├── mart/
│ │ ├── dim_date.sql
│ │ ├── dim_station.sql
│ │ ├── fact_station_hourly_usage.sql
│ │ └── schema.yml
│ └── staging/
│ ├── stg_station_information.sql
│ ├── stg_station_status.sql
│ └── schema.yml
└── .github/
└── workflows/
└── schedule_dbt_job.yml
```

---

## Power BI Dashboard

The dashboard includes:

- Daily usage trends
- Top and bottom stations by usage
- Peak usage hours
- Availability ratio and turnover

### Screenshot Preview

![Power BI Dashboard Screenshot](./powerbi/dashboard-preview.png)

### 🔗 Online Dashboard Access

_(Link will be added once available – e.g., Power BI public link or embedded iframe)_  
[View dashboard](#)

---

## Roadmap

The Nantes Mobility project is just getting started. Here's a preview of the next steps planned to gradually enhance the platform, while keeping simplicity and cost-efficiency in mind:

- Integrate Azure Blob Storage to archive data and reduce Snowflake storage costs

- Create a public static website to share dashboards and key mobility insights

- Add weather data correlation to better understand factors impacting usage

- Identify under-served areas based on spatial and temporal usage patterns

- Generate weekly automated summary reports (PDF or dashboard snapshots)

- Set up an alert system for detecting saturation or abnormal station behavior

- Explore a lightweight multi-city extension, keeping the pipeline configurable

- Keep infrastructure and compute as low-cost and maintainable as possible

---

## Author

**Lucas Zubiarrain** Data Engineer | Analytics Engineer | Cloud & BI Solutions
📇 [LinkedIn](https://linkedin.com/in/lucaszubiarrain)

---

## License

MIT License – feel free to fork, adapt, and build upon this project.
