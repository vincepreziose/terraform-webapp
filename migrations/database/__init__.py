from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, scoped_session


class Database:
    """Maintains a database session and declarative base for SQLAlchemy."""

    def __init__(self):
        self.Base = declarative_base()

    def init_db(self, database_uri):
        self.engine = create_engine(database_uri)
        self.session_local = sessionmaker(autocommit=False, autoflush=False, bind=self.engine)
        self.session = scoped_session(self.session_local)


db = Database()