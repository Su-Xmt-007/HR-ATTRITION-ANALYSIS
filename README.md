# 🧠 HR Attrition Analysis
### *Uncovering the Hidden Drivers of Employee Turnover — From Raw Data to Predictive Intelligence*

![Python](https://img.shields.io/badge/Python-3.10%2B-blue?style=for-the-badge&logo=python&logoColor=white)
![Scikit-Learn](https://img.shields.io/badge/Scikit--Learn-ML%20Pipeline-orange?style=for-the-badge&logo=scikit-learn&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow?style=for-the-badge&logo=powerbi&logoColor=black)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Analysis-150458?style=for-the-badge&logo=pandas&logoColor=white)
![Matplotlib](https://img.shields.io/badge/Matplotlib-Visualization-11557c?style=for-the-badge)
![GitHub](https://img.shields.io/badge/GitHub-Version%20Control-181717?style=for-the-badge&logo=github&logoColor=white)

---

## 📌 Project Overview

Employee attrition is one of the most costly and disruptive challenges facing modern organizations. Replacing a single employee can cost **50–200% of their annual salary** — yet most HR departments still rely on gut feeling rather than data to make retention decisions.

This project transforms raw IBM HR data (1,470 employees) into a fully automated, end-to-end analytics solution. Using Python for statistical analysis and machine learning, combined with a professional Power BI dashboard, this project identifies **who is leaving, why they are leaving, and who is most likely to leave next** — giving HR teams the intelligence to act before it's too late.

> **Business Impact:** The analysis revealed a critical "Danger Zone" — employees working overtime with no stock options — who leave at a staggering **45.1% attrition rate**, nearly 3× the company average. A predictive machine learning model was then trained to flag at-risk employees with high accuracy, enabling proactive, data-driven retention strategies.

---

## ✨ Key Features & Deliverables

- 🔍 **Exploratory Data Analysis (EDA)** — Deep statistical profiling of 1,470 employees across departments, roles, income bands, and tenure groups
- 📊 **Interactive Power BI Dashboard** — A two-page professional dashboard with conditional formatting, dynamic slicers, KPI cards, and cross-filtering
- 🤖 **Predictive ML Model** — A classification model (Random Forest / Logistic Regression via Scikit-learn) to predict flight-risk employees
- ⚙️ **Automated ML Pipeline** — `pipeline.py` handles data ingestion, preprocessing, feature engineering, model training, and evaluation end-to-end
- 📄 **Automated Report Generation** — `report_gen.py` auto-generates all key visualizations and exports them to the `/REPORTS` folder
- 📈 **Statistical Validation** — Chi-square tests, ANOVA, z-scores, and log transformations to confirm findings are statistically significant
- 🎯 **Actionable Segmentation** — Combined Travel × Stock Options segmentation to identify highest and lowest risk employee groups

---

## 🗂️ Repository Structure

```
HR-ATTRITION-ANALYSIS/
│
├── 📁 REPORTS/                        # Auto-generated visualizations
│   ├── log_transform.png              # Income distribution before/after log transform
│   ├── clt_demo.png                   # Central Limit Theorem demonstration
│   ├── push_pull.png                  # Push vs Pull attrition factor analysis
│   ├── scatter_matrix.png             # Feature correlation scatter matrix
│   ├── driver_profile.png             # Top attrition driver profile chart
│   ├── confusion_matrix.png           # ML model confusion matrix
│   ├── feature_importances.png        # Random Forest feature importance rankings
│   └── roc_curve.png                  # ROC-AUC curve for model evaluation
│
├── 📁 SCRIPTS/                        # Core Python scripts
│   ├── pipeline.py                    # End-to-end ML pipeline (ingest → train → evaluate)
│   └── report_gen.py                  # Automated visualization and report generator
│
└── README.md                          # You are here
```

---

## 🔑 Key Insights & Visualizations

### 1. 💀 The Danger Zone — Overtime × Stock Options

The single most dangerous employee combination in the dataset:

| Segment | Attrition Rate |
|---|---|
| Overtime + No Stock Options | **45.1%** 🔴 |
| Overtime + Stock Level 1 | 17.4% 🟡 |
| No Overtime + Has Stock | 3.3% 🟢 |

> **Insight:** Simply giving Level 1 stock options to overtime workers **reduces attrition from 45.1% to 17.4%** — a 61% reduction. Small ownership stake = powerful retention tool.

---

### 2. 📉 Attrition Driver Profile

<img width="1474" height="871" alt="p2_fig04_driver_profile" src="https://github.com/user-attachments/assets/1491b1a2-76d3-46ae-bd54-b77e8550c03a" />


- **Sales Representatives** leave at **39.8%** — nearly **8× the Manager rate (5.0%)**
- Pattern confirmed: Lower income → Higher attrition (ANOVA F=810.21, p<0.001)
- **Sales** department has highest overall attrition at **20.6%**

---

### 3. 📈 Income Distribution — Log Transformation

<img width="4000" height="1000" alt="p2_fig01_log_transform" src="https://github.com/user-attachments/assets/b957a434-6b79-4975-8416-1f7c13fd034b" />


Raw income data was heavily right-skewed. Log transformation was applied to normalize the distribution for accurate statistical modeling.

---

### 4. 🔗 Feature Correlation Matrix

<img width="1300" height="1093" alt="p2_fig03_scatter_matrix" src="https://github.com/user-attachments/assets/712781dd-382e-4453-bc04-aaf8e2fa4022" />


Multivariate analysis revealed key correlated features driving attrition, including `overtime`, `stock_option_level`, `business_travel`, `years_at_company`, and `monthly_income`.

---

### 5. ↕️ Push vs Pull Attrition Factors

<img width="1474" height="871" alt="p2_fig03_push_pull" src="https://github.com/user-attachments/assets/9a69c3b8-d215-4c63-b883-994e5f97fe10" />


Employees leave due to both **push factors** (low pay, high workload, poor satisfaction) and **pull factors** (better opportunities, career growth). This chart quantifies both dimensions.

---

### 6. 🤖 Machine Learning Model Performance

<img width="1032" height="725" alt="p3_roc_curve" src="https://github.com/user-attachments/assets/bbc26c1c-2c45-45f1-9b6a-3f48786b2265" />


<img width="846" height="733" alt="p3_confusion_matrix" src="https://github.com/user-attachments/assets/7d625d62-f3ca-445a-8c21-be96d7d14ef0" />


<img width="1335" height="727" alt="p3_feature_importances" src="https://github.com/user-attachments/assets/1371bd7d-1cd9-43f1-9a79-579f7e11adfb" />


| Metric | Score |
|---|---|
| Model Accuracy | **~85%** |
| ROC-AUC Score | **~0.87** |
| Top Predictor | `overtime` + `stock_option_level` |

> The model successfully identifies **flight-risk employees** before they resign, enabling HR to intervene with targeted retention offers.

---

### 7. 🧪 Statistical Validation

<img width="1514" height="595" alt="p2_fig02_clt_demo" src="https://github.com/user-attachments/assets/ff9b4d46-efdb-40de-9f4f-94b5e0100929" />


- **Chi-square test:** Overtime × Attrition — χ²=87.56, p<0.001 ✅
- **Z-score:** Company attrition (16.12%) vs industry benchmark (13%) — z=3.26, p<0.001 ✅
- **ANOVA:** Income gap across job roles — F=810.21, p<0.001 ✅

All key findings are **statistically significant** — not random chance.

---

## 🚀 Getting Started

### Prerequisites

Make sure you have Python 3.10+ installed. Then install required libraries:

```bash
pip install pandas numpy matplotlib seaborn scikit-learn sqlalchemy psycopg2
```

### Installation

**Step 1 — Clone the repository:**
```bash
git clone https://github.com/Su-Xmt-007/HR-ATTRITION-ANALYSIS.git
cd HR-ATTRITION-ANALYSIS
```

**Step 2 — Run the ML Pipeline:**
```bash
cd SCRIPTS
python pipeline.py
```

This will:
- Load and preprocess the HR dataset
- Engineer features (Tenure Band, Combo Segment, Risk Level)
- Train the classification model
- Output accuracy, ROC-AUC, and confusion matrix to console

**Step 3 — Generate All Visualizations:**
```bash
python report_gen.py
```

This will:
- Auto-generate all 8 charts
- Save them to the `/REPORTS` folder
- Ready for README rendering and presentation use

---

## 📊 Power BI Dashboard

The interactive Power BI dashboard provides a two-page executive-level view:

**HR Attrition Analysis:**

<img width="1185" height="513" alt="HR Attrition Analysis Dashboard top half" src="https://github.com/user-attachments/assets/d4c0ccc0-e570-4081-80b1-5c5ab3d03cb6" />
<img width="1184" height="507" alt="HR Attrition Analysis Dashboard bottom half" src="https://github.com/user-attachments/assets/9eb0f26f-341b-469a-9160-0a1b37b4f456" />

- 6 KPI cards (Attrition Rate, Total Employees, Income Gap, High Risk Count, Danger Zone Rate, Safe Zone Rate)
- Department, Marital Status, and Tenure attrition breakdowns
- Overtime donut chart and narrative story band
- Combined Travel × Stock Options risk segmentation
- Job role income vs attrition table
- Actionable insight cards with recommended interventions

**Dashboard highlights:**
- Dynamic tenure slicer (0-2 yrs / 3-5 yrs / 6-9 yrs / 10+ yrs)
- Conditional color coding (🔴 Red = Danger / 🟡 Amber = Warning / 🟢 Green = Safe)
- Cross-filtering between all visuals for deep drill-down

---

## 🎯 Conclusion & Next Steps

This project demonstrates a **complete data analytics workflow** — from raw PostgreSQL data through statistical analysis, machine learning, and executive-level visualization.

### What was achieved:
- ✅ Identified the highest-risk employee segments with statistical confidence
- ✅ Built an automated ML pipeline predicting attrition with ~85% accuracy
- ✅ Delivered an interactive Power BI dashboard for HR decision-makers
- ✅ Quantified the ROI of stock options as a retention tool (61% attrition reduction)

### Future Enhancements:
- 🔮 **Real-time scoring** — Connect pipeline to live HRIS database for continuous risk scoring
- 🧠 **Deep Learning model** — Experiment with neural networks for improved accuracy
- 📧 **Automated alerts** — Email HR managers when employee risk score crosses threshold
- 🌐 **Streamlit web app** — Deploy model as interactive web application
- 📅 **Cohort analysis** — Track retention improvements over time after interventions

---

## 👤 Author

**Subhamoy Hazra**
- 📊 Data Analytics Portfolio Project — FY 2024
- 🔗 [GitHub Profile](https://github.com/Su-Xmt-007)
- 🛠️ Built with: Python · Power BI · Scikit-learn · PostgreSQL · Pandas · Matplotlib

---

## 📜 License

This project is open source and available under the [MIT License](LICENSE).

---

*⭐ If you found this project useful, please consider giving it a star on GitHub!*
