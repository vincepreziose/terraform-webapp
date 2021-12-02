import os
import boto3
from psycopg2 import pool, sql
import logging
import asyncio
import functools
import time

UPSERTER_QUERIES = [
    'apn_taxnum',
]

LOG_LEVEL = os.environ["LOG_LEVEL"]

logger = logging.getLogger()
if LOG_LEVEL == "INFO":
    logger.setLevel(logging.INFO)
if LOG_LEVEL == "WARN":
    logger.setLevel(logging.WARN)
elif LOG_LEVEL == "ERROR":
    logger.setLevel(logging.ERROR)
else:
    logger.setLevel(logging.INFO)


# Get DB schema
etlschema   = os.environ["ETL_TARGET_SCHEMA"]
rds_data    = boto3.client('rds-data')
cluster_arn = os.environ["STARTER_DBCLUSTER_ARN"]
secret_arn  = os.environ["STARTER_DB_CREDENTIALS_ARN"]

# async def main():
#     loop = asyncio.get_running_loop()
#
#     try:
#
#         # Execute a query
#         logger.info("Upserter Loop Begins:")
#         logger.info(",".join(UPSERTER_QUERIES))
#         for upserter_query in UPSERTER_QUERIES:
#             try:
#                 logger.info(f"Upserter-->{upserter_query}")
#                 with open(f"upserter_{upserter_query}.sql", 'r') as sqlfile:
#                     data = sqlfile.read().replace('\n', ' ')
#                     data = data.format(etlschema=etlschema)
#                     logger.info(f'cluster_arn: {cluster_arn}')
#                     logger.info(f'secret_arn: {secret_arn}')
#                     logger.info(f'database: {os.environ["STARTER_DBNAME"]}')
#                     logger.info(f'upserter sql: {data}')
#                     response = loop.run_in_executor(None, functools.partial(rds_data.execute_statement, resourceArn=cluster_arn,
#                                                           secretArn=secret_arn,
#                                                           database=os.environ["STARTER_DBNAME"],
#                                                           sql=data,
#                                                           continueAfterTimeout=True))
#                     time.sleep(5)
#
#             except Exception as e:
#                 logger.info(f"Query Failed On {upserter_query}{e}")
#                 raise Exception(f"Query Failed On {upserter_query}", e)
#
#         logger.info("Upserter Complete...")
#
#     except Exception as e:
#         logger.info(f"Upserter Failed-->{e}")
#         raise Exception('Error executing query', e)


def handler(event, context):
    upserter_query = 'apn_taxnum'
    logger.info(f"Upserter-->{upserter_query}")

    response = execute_statement('select * from blue.staging_apn_taxnum')
    return response

def execute_statement(sql):
    response = rds_data.execute_statement(
        resourceArn=cluster_arn,
        secretArn=secret_arn,
        database=os.environ["STARTER_DBNAME"],
        sql=sql
    )

    return response
