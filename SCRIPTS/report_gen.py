import pandas as pd, os
from datetime import datetime

def generate_report(data_path, output_path):
    df   = pd.read_csv(data_path)
    stay = df[df["Attrition"]==0]
    left = df[df["Attrition"]==1]
    now  = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    attrition_pct = round(df["Attrition"].mean() * 100, 2)
    income_gap    = int(stay["MonthlyIncome"].mean() - left["MonthlyIncome"].mean())
    ot_yes        = round(df[df["OverTime"]==1]["Attrition"].mean() * 100, 1)
    ot_no         = round(df[df["OverTime"]==0]["Attrition"].mean() * 100, 1)
    top_roles     = df.groupby("JobRole")["Attrition"].mean().mul(100).round(1).sort_values(ascending=False).head(3)
    parts = [
        "IBM HR ATTRITION -- AUTOMATED REPORT",
        "Generated: " + now,
        "=====================================",
        "OVERVIEW",
        "  Total      : " + str(len(df)),
        "  Left       : " + str(int(df["Attrition"].sum())) + " (" + str(attrition_pct) + "%)",
        "INCOME GAP",
        "  Stayed avg : " + str(int(stay["MonthlyIncome"].mean())),
        "  Left avg   : " + str(int(left["MonthlyIncome"].mean())),
        "  Gap        : " + str(income_gap) + " per month",
        "OVERTIME RISK",
        "  With OT    : " + str(ot_yes) + "%",
        "  Without OT : " + str(ot_no) + "%",
        "TOP 3 ROLES",
        top_roles.to_string(),
        "====================================="
    ]
    report = chr(10).join(parts)
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with open(output_path, "w") as f: f.write(report)
    print(report)

if __name__ == "__main__":
    generate_report("../data/hr_cleaned.csv", "../reports/attrition_report.txt")