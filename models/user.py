#!/usr/bin/python3
from models.base_model import BaseModel


class User(BaseModel):
    """Represents a user for a MySQL database.

    Attributes:
        email: The user's email address.
        password: The user's password.
        first_name: The user's first name.
        last_name: The user's last name.
        places: The User-Place relationship.
        reviews: The User-Review relationship.
    """
    email = Column(String(128), nullable=False)
    password = Column(String(128), nullable=False)
    first_name = Column(String(128))
    last_name = Column(String(128))
    places = relationship("Place", backref="user", cascade="delete")
    reviews = relationship("Review", backref="user", cascade="delete")

    def __init__(self, email, password, first_name, last_name):
        self.email = email
        self.password = password
        self.first_name = first_name
        self.last_name = last_name

    def __setattr__(self, name, value):
        """Encodes passwords using MD5 before setting an attribute."""
        if name == "password":
            value = value.encode("utf-8")
            value = md5(value).hexdigest()
        super().__setattr__(name, value)
