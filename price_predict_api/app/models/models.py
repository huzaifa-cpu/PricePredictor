from app.config.database import Base
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship


class User(Base):
    __tablename__ = "user"

    id = Column(
        String(255),
        primary_key=True,
        nullable=False,
    )
    name = Column(String(255))
    email = Column(String(255))
    photo = Column(String(255))

    histories = relationship("History", back_populates="user")


class History(Base):
    __tablename__ = "history"

    id = Column(Integer, primary_key=True, nullable=False, autoincrement=True)
    brand = Column(String(255))
    model = Column(String(255))
    city = Column(String(255))
    mode = Column(String(255))
    fuel_type = Column(String(255))
    cc = Column(String(255))
    km = Column(String(255))
    year = Column(String(255))
    price = Column(String(255))
    user_id = Column(String(255), ForeignKey("user.id"))

    user = relationship("User", back_populates="histories")
