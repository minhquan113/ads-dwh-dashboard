import os
from google.cloud import bigquery
import requests

PROJECT = os.environ["GCP_PROJECT"]
DATASET = os.environ["GCP_DATASET"]
SLACK_WEBHOOK_URL = os.environ.get("SLACK_WEBHOOK_URL")

def check_outliers():
    client = bigquery.Client(project=PROJECT)
    query = f"""
        SELECT start_date, account_id, campaign_id, ad_id, platform, spend, z_score
        FROM `{PROJECT}.{DATASET}.fct_ad_performance_outliers`
        ORDER BY spend DESC
        LIMIT 20
    """
    rows = list(client.query(query).result())

    if not rows:
        print("No outliers detected today.")
        return

    lines = [f"🚨 {len(rows)} spend outlier(s) detected"]
    for r in rows:
        lines.append(
            f"- {r.platform} | campaign {r.campaign_id} | ad {r.ad_id} "
            f"| spend: {r.spend:,.0f} | z-score: {r.z_score:.2f}"
        )
    message = "\n".join(lines)
    print(message)

    if SLACK_WEBHOOK_URL:
        requests.post(SLACK_WEBHOOK_URL, json={"text": message})

if __name__ == "__main__":
    check_outliers()