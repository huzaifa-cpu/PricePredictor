from app.models import models, schemas
from fastapi import HTTPException, status
from sqlalchemy.orm import Session

# Methods
def get_histories(db: Session):
    histories = db.query(models.History).all()
    return histories


def get_history(id: int, db: Session):
    history = db.query(models.History).filter(models.History.id == id).first()
    if not history:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail="history not exists"
        )
    return history


def post_history(request: schemas.History, db: Session):
    history = models.History(
        brand=request.brand,
        model=request.model,
        city=request.city,
        mode=request.mode,
        fuel_type=request.fuel_type,
        cc=request.cc,
        km=request.km,
        year=request.year,
        price=request.price,
        user_id=request.user_id,
    )

    db.add(history)
    db.commit()
    db.refresh(history)
    return history


def delete_history(id: int, db: Session):
    history = db.query(models.History).filter(models.History.id == id)
    if not history.first():
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail="history not exists"
        )

    history.delete()

    db.commit()
    return "deleted"


def update_history(id: int, request: schemas.History, db: Session):
    history = db.query(models.History).filter(models.History.id == id)
    if not history.first():
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, detail="history not exists"
        )

    history.update(
        {
            "id": request.id,
            "brand": request.brand,
            "model": request.model,
            "city": request.city,
            "mode": request.mode,
            "fuel_type": request.fuel_type,
            "cc": request.cc,
            "km": request.km,
            "year": request.year,
            "price": request.price,
            "user_id": request.user_id,
        }
    )
    db.commit()
    return "updated"


# GET USER HISTORIES
def get_user_histories(user_id: str, db: Session):
    histories = db.query(models.History).all()
    user_histories = []
    for history in histories:
        if history.user_id == user_id:
            user_histories.append(history)
    return user_histories
