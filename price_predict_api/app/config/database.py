from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# SQLALCHAMY_DATABASE_URL = 'mysql+pymysql://root:dexter456@localhost:3306/price'
SQLALCHAMY_DATABASE_URL = "postgresql://pzbdkhjemoexdt:7602ce040fc40f5b991beef8f9f15d77be066af91949641a0ca2f2e892c91aa4@ec2-23-20-73-25.compute-1.amazonaws.com:5432/d3gctesp27vlsf"

engine = create_engine(SQLALCHAMY_DATABASE_URL)

SessionLocal = sessionmaker(
    bind=engine,
    autocommit=False,
    autoflush=False,
)

Base = declarative_base()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
