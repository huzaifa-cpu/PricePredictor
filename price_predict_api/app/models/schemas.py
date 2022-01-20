from pydantic import BaseModel


class User(BaseModel):
    id: str
    name: str
    email: str
    photo: str


class History(BaseModel):
    id: int
    brand: str
    model: str
    city: str
    mode: str
    fuel_type: str
    cc: str
    km: str
    year: str
    price: str
    user_id: str


class Feature(BaseModel):
    brand: str
    model: str
    city: str
    mode: str
    fuel_type: str
    cc: int
    km: int
    year: int
