import pandas as pd, numpy as np, logging, os
from datetime import datetime
os.makedirs("../logs", exist_ok=True)
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s  %(levelname)s  %(message)s",
    handlers=[logging.FileHandler("../logs/pipeline.log"), logging.StreamHandler()]
)
log = logging.getLogger(__name__)

def extract(filepath):
    log.info("Extracting: " + filepath)
    df = pd.read_csv(filepath)
    log.info("Extracted: " + str(df.shape[0]) + " rows")
    return df

def transform(df):
    log.info("Starting transform...")
    df.drop(columns=["EmployeeCount","StandardHours","Over18"], inplace=True, errors="ignore")
    df["Attrition"] = df["Attrition"].map({"Yes":1,"No":0})
    df["Income_Zscore"] = stats.zscore(df["MonthlyIncome"]).round(3)
    df["OverTime"]  = df["OverTime"].map({"Yes":1,"No":0})
    df["Gender"]    = df["Gender"].map({"Male":1,"Female":0})
    for col in ["Department","JobRole","MaritalStatus","BusinessTravel"]:
        if col in df.columns: df[col] = df[col].str.strip().str.title()
    df["IsHighRisk"]        = np.where((df["OverTime"]==1) & (df["JobSatisfaction"]<=2), 1, 0)
    df["AnnualIncome"]      = df["MonthlyIncome"] * 12
    df["SatisfactionScore"] = df[["JobSatisfaction","EnvironmentSatisfaction","RelationshipSatisfaction","WorkLifeBalance"]].mean(axis=1)
    df["TenureGroup"]       = pd.cut(df["YearsAtCompany"], bins=[-1,2,5,10,40], labels=["0-2","3-5","6-10","10+"])
    df["DeptAvgIncome"]     = df.groupby("Department")["MonthlyIncome"].transform("mean")
    df["Below_Dept_Avg"]    = np.where(df["MonthlyIncome"] < df["DeptAvgIncome"], 1, 0)
    log.info("Transform done: " + str(df.shape[0]) + " rows x " + str(df.shape[1]) + " cols")
    return df

def load(df, output_path):
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    df.to_csv(output_path, index=False)
    log.info("Saved: " + output_path)

def run_pipeline():
    start = datetime.now()
    log.info("Pipeline STARTED")
    df_raw   = extract("../data/ibm_hr_raw.csv")
    df_clean = transform(df_raw)
    load(df_clean, "../data/ibm_hr_stats_ready.csv")
    elapsed = (datetime.now() - start).seconds
    log.info("Pipeline DONE in " + str(elapsed) + "s")
    return df_clean

if __name__ == "__main__":
    df = run_pipeline()
    print("Pipeline complete.")