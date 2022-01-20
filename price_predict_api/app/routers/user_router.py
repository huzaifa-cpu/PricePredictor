from fastapi import Depends, status, APIRouter
from app.models import schemas
from app.repository import user_repository
from sqlalchemy.orm import Session
from app.config import database

router = APIRouter(tags=["USER"])

# Methods
@router.get("/get-users")
def get_users(db: Session = Depends(database.get_db)):
    return user_repository.get_users(db=db)


@router.get("/get-user/{id}", status_code=200)
def get_user(id: str, db: Session = Depends(database.get_db)):
    return user_repository.get_user(id=id, db=db)


@router.post("/post-user", status_code=status.HTTP_201_CREATED)
def post_user(request: schemas.User, db: Session = Depends(database.get_db)):
    return user_repository.post_user(request=request, db=db)


@router.delete("/delete-user/{id}")
def delete_user(id: str, db: Session = Depends(database.get_db)):
    return user_repository.delete_user(id=id, db=db)


@router.put("/put-user/{id}", status_code=status.HTTP_202_ACCEPTED)
def update_user(id: str, request: schemas.User, db: Session = Depends(database.get_db)):
    return user_repository.update_user(id=id, request=request, db=db)
