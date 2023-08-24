#!/usr/bin/python3
""" City Module for HBNB project """
from models.base_model import BaseModel
from sqlalchemy import Column, String
from sqlalchemy.orm import relationship

class City(BaseModel):
    """ The city class, contains state ID and name """
    __tablename__ = 'cities'  # Table name as requested

    state_id = Column(String(60), nullable=False)
    name = Column(String(128), nullable=False)

    # Add a one-to-many relationship to Place
    places = relationship("Place", backref="cities", cascade="all, delete-orphan")
