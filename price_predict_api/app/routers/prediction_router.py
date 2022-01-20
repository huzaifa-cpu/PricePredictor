from fastapi import APIRouter
from app.models import schemas
from app.repository import prediction_repository

router = APIRouter(tags=["PREDICTION"])

# Methods
@router.post("/predict")
def prediction(request: schemas.Feature):
    return prediction_repository.prediction(request=request)