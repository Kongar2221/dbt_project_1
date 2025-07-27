# 🎬 Rental Store Analytics Project

A data analytics pipeline simulating a Blockbuster-style rental store. This project demonstrates a full-stack workflow using **DBeaver**, **Supabase**, **DBT**, and **VS Code**, with optional **Power BI** integration and deployment on **GitHub**.

---

## 📦 Tech Stack

- 🐘 **PostgreSQL** via [Supabase](https://supabase.io/)
- 🧠 **DBT (Data Build Tool)** for data modeling and transformation
- 💻 **VS Code** for development
- 🗃️ **DBeaver** for SQL and database loading
- 🌐 **Git & GitHub** for version control
- 📊 *(Optional)* **Power BI** for dashboard visualizations

---

## 🗂️ Project Structure

```bash
DBT_Project_1/
├── dbt_project.yml
├── models/
│   ├── staging/       # Clean raw tables
│   ├── marts/         # Business logic models
│   └── ...
├── snapshots/         # Change tracking (if any)
├── seeds/             # Static seed data (if used)
├── target/            # DBT compiled files
├── .gitignore
└── README.md
