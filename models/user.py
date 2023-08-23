#!/usr/bin/python3
"""This module defines a class User"""
from models.base_model import BaseModel
from sqlalchemy import Column, String


class User(BaseModel):
    """This class defines a user by various attributes"""
    __tablename__ = 'users'  # Table name for SQLAlchemy

    email = Column(String(128), nullable=False)
    password = Column(String(128), nullable=False)
    first_name = Column(String(128))
    last_name = Column(String(128))
