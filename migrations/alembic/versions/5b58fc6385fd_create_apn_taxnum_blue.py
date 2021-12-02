"""create apn taxnum blue

Revision ID: 5b58fc6385fd
Revises: 
Create Date: 2021-11-06 13:40:09.064526

"""
from alembic import op
import sqlalchemy as sa
import datetime


# revision identifiers, used by Alembic.
revision = '5b58fc6385fd'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    op.create_table(
        "apn_taxnum",
        sa.Column("idid", sa.Numeric(38, 0), nullable=True),
        sa.Column("fileid", sa.Numeric(38, 0), nullable=True),
        sa.Column("propertyid", sa.Numeric(38, 0), nullable=True),
        sa.Column("taxid", sa.Numeric(38, 0), nullable=True),
        sa.Column("taxclasstype", sa.String(40), nullable=True),
        sa.Column("taxtype", sa.String(70), nullable=True),
        sa.Column("taxnum", sa.String(45), nullable=True),
        sa.Column("taxyear", sa.String(10), nullable=True),
        sa.Column("taxrateareanum", sa.String(30), nullable=True),
        sa.Column("insertdate", sa.DateTime(9), default=datetime.datetime.utcnow, nullable=True),
        sa.Column("updatedate", sa.DateTime(9), default=datetime.datetime.utcnow, nullable=True),
        schema="blue",
    )

    op.create_index(
        "idx_apn_taxnum_fileid",
        "apn_taxnum",
        ["fileid"],
        "blue",
        False,
    )


def downgrade():
    op.drop_table(
        "apn_taxnum",
        "blue"
    )
