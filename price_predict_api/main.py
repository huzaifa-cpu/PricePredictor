from fastapi import FastAPI
from app.config.database import engine, Base
from app.routers import user_router, history_router, prediction_router

# Initialize
app = FastAPI()

# This will create automatic database in workbench
Base.metadata.create_all(engine)

# ROUTERS
app.include_router(user_router.router)
app.include_router(history_router.router)
app.include_router(prediction_router.router)


