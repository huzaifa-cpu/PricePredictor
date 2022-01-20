from fastapi import Depends, status, APIRouter
from app.models import schemas
from app.repository import history_repository
from sqlalchemy.orm import Session
from app.config import database

router = APIRouter(tags=["HISTORY"])

# Methods
@router.get("/get-histories")
def get_histories(db: Session = Depends(database.get_db)):
    return history_repository.get_histories(db=db)


@router.get("/get-history/{id}", status_code=200)
def get_history(id: int, db: Session = Depends(database.get_db)):
    return history_repository.get_history(id=id, db=db)


@router.post("/post-history", status_code=status.HTTP_201_CREATED)
def post_history(request: schemas.History, db: Session = Depends(database.get_db)):
    return history_repository.post_history(request=request, db=db)


@router.delete("/delete-history/{id}")
def delete_history(id: int, db: Session = Depends(database.get_db)):
    return history_repository.delete_history(id=id, db=db)


@router.put("/put-history/{id}", status_code=status.HTTP_202_ACCEPTED)
def update_history(
    id: int, request: schemas.History, db: Session = Depends(database.get_db)
):
    return history_repository.update_history(id=id, request=request, db=db)


# GET USER HISTORIES
@router.get("/get-user-histories/{user_id}")
def get_user_histories(user_id: str, db: Session = Depends(database.get_db)):
    return history_repository.get_user_histories(user_id=user_id, db=db)
