from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta
import subprocess

DBT_PROJECT_DIR = "/opt/airflow/dbt/ads_dwh"

default_args = {"owner": "quan", "retries": 1, "retry_delay": timedelta(minutes=5)}


def run_alert_script():
    subprocess.run(
        ["python", f"{DBT_PROJECT_DIR}/scripts/alert_outliers.py"], check=True
    )
    return None


with DAG(
    dag_id="ads_outlier_detection_daily",
    default_args=default_args,
    schedule="0 7 * * *",
    start_date=datetime(2026, 7, 1),
    catchup=False,
    tags=["dbt", "ads", "outlier-detection"],
) as dag:

    dbt_run = BashOperator(
        task_id="dbt_run_outlier_model",
        bash_command=f"cd {DBT_PROJECT_DIR} && dbt run --select fct_ad_performance_outliers",
    )

    dbt_test = BashOperator(
        task_id="dbt_test_outlier_model",
        bash_command=f"cd {DBT_PROJECT_DIR} && dbt test --select fct_ad_performance_outliers",
    )

    send_alert = PythonOperator(
        task_id="check_and_send_alert",
        python_callable=run_alert_script,
    )

    dbt_run >> dbt_test >> send_alert
