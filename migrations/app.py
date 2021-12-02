import os

from alembic.config import Config
import alembic.command

SQLALCHEMY_DATABASE_URI = os.getenv('SQLALCHEMY_DATABASE_URI')
API_PYTHON_PATH = os.getenv('API_PYTHON_PATH')


def handler(event, context):
    """ An AWS lambda function to handle database migrations using the alembic migration tool

    :param event: The event data for the lambda function
    :param context: The environment context for the lambda function
    :return: Simple success string on completion
    """
    alembic_path = f"{API_PYTHON_PATH}/migrations/alembic.ini"
    alembic_cfg = Config(alembic_path)

    migration_type = event.get('migration_type', '')
    print(f'Migration type is: {migration_type}')
    revision = event.get('revision', 'head')

    # alembic.command.upgrade(alembic_cfg, revision)  # this is a test. remove this.

    if migration_type == '':
        return "No migration type specified"
    elif migration_type == 'upgrade':
        alembic.command.upgrade(alembic_cfg, revision)
    elif migration_type == 'downgrade':
        if revision and revision != 'head':
            alembic.command.downgrade(alembic_cfg, revision)
        else:
            return "No revision specified for downgrade"

    return f"{migration_type} successful for revision {revision}"
