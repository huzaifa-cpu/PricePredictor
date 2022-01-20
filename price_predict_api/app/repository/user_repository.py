from app.models import models, schemas
from fastapi import HTTPException, status
from sqlalchemy.orm import Session

# Methods
def get_users(db: Session):
    users = db.query(models.User).all()
    return users


def get_user(id: str, db: Session):
    user = db.query(models.User).filter(models.User.id == id).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail="user not exists"
        )
    return user


def post_user(request: schemas.User, db: Session):
    user = models.User(
        id=request.id,
        name=request.name,
        email=request.email,
        photo=request.photo,
    )

    db.add(user)
    db.commit()
    db.refresh(user)
    return user


def delete_user(id: str, db: Session):
    user = db.query(models.User).filter(models.User.id == id)
    if not user.first():
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail="user not exists"
        )

    user.delete()

    db.commit()
    return "deleted"


def update_user(id: str, request: schemas.User, db: Session):
    user = db.query(models.User).filter(models.User.id == id)
    if not user.first():
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail="user not exists"
        )

    user.update(
        {
            "id": request.id,
            "name": request.name,
            "email": request.email,
            "photo": request.photo,
        }
    )
    db.commit()
    return "updated"
