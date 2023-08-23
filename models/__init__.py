#!/usr/bin/python3
"""This module instantiates a storage object"""
import os

# Check the value of the HBNB_TYPE_STORAGE environment variable
storage_type = os.environ.get('HBNB_TYPE_STORAGE')

if storage_type == 'db':
    from models.engine.db_storage import DBStorage
    storage = DBStorage()
else:
    from models.engine.file_storage import FileStorage
    storage = FileStorage()

# Reload the storage
storage.reload()
