#!/usr/bin/python3
"""This module defines a class User"""
from models.base_model import BaseModel
from sqlalchemy import Column, String
from sqlalchemy.orm import relationship

class User(BaseModel):
    """This class defines a user by various attributes"""

    __tablename__ = 'users'  # Table name as requested

    email = Column(String(128), nullable=False)
    password = Column(String(128), nullable=False)
    first_name = Column(String(128))
    last_name = Column(String(128))

    # Add a one-to-many relationship to Place
    places = relationship("Place", backref="user", cascade="all, delete-orphan")
