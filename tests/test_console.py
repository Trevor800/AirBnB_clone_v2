#!/usr/bin/python3
''' Test suite for the console'''

import os
import sys
import models
import unittest
from io import StringIO
from console import HBNBCommand
from unittest.mock import create_autospec
import json


class test_console(unittest.TestCase):
    ''' Test the console module'''

    """Check for Pep8 style conformance"""

    def setUp(self):
        '''setup for'''
        self.backup = sys.stdout
        self.capt_out = StringIO()
        sys.stdout = self.capt_out
        self.storage = models.Storage()

    def tearDown(self):
        ''''''
        sys.stdout = self.backup
        self.storage.clear()

    def create(self):
        ''' create an instance of the HBNBCommand class'''
        return HBNBCommand(self.storage)

    def test_quit(self):
        ''' Test quit exists'''
        console = self.create()
        self.assertTrue(console.onecmd("quit"))

    def test_EOF(self):
        ''' Test EOF exists'''
        console = self.create()
        self.assertTrue(console.onecmd("EOF"))

    def test_all(self):
        ''' Test all exists'''
        console = self.create()
        console.onecmd("create User")
        self.assertTrue(isinstance(self.capt_out.getvalue(), str))

    @unittest.skipIf(
        os.getenv('HBNB_TYPE_STORAGE') == 'db',
        "won't work in db")
    def test_show(self):
        '''
            Testing that show exists
        '''
        console = self.create()
        console.onecmd("create User")
        user_id = self.capt_out.getvalue()
        sys.stdout = self.backup
        self.capt_out.close()
        self.capt_out = StringIO()
        sys.stdout = self.capt_out
        console.onecmd("show User " + user_id)
        x = (self.capt_out.getvalue())
        sys.stdout = self.backup
        self.assertTrue(isinstance(x, str))
        self.assertTrue(json.loads(x)['id'] == user_id)

    @unittest.skipIf(
        os.getenv('HBNB_TYPE_STORAGE') == 'db',
        "won't work in db")
    def test_show_class_name(self):
        '''
            Testing the error messages for class name missing.
        '''
        console = self.create()
        console.onecmd("create User")
        user_id = self.capt_out.getvalue()
        sys.stdout = self.backup
        self.capt_out.close()
        self.capt_out = StringIO()
        sys.stdout = self.capt_out
        console.onecmd("show")
        x = (self.capt_out.getvalue())
        sys.stdout = self.backup
        self.assertEqual("** class name missing **\n", x)

    @unittest.skipIf(
        os.getenv('HBNB_TYPE_STORAGE') == 'db',
        "won't work in db")
    def test_show_class_name(self):
        '''
            Test show message error for id missing
        '''
        console = self.create()
        console.onecmd("create User")
        user_id = self.capt_out.getvalue()
        sys.stdout = self.backup
        self.capt_out.close()
        self.capt_out = StringIO()
        sys.stdout = self.capt_out
        console.onecmd("show User")
        x = (self.capt_out.getvalue())
        sys.stdout = self.backup
        self.assertEqual("** instance id missing **\n", x)

    @unittest.skipIf(
        os.getenv('HBNB_TYPE_STORAGE') == 'db',
        "won't work in db")
    def test_show_no_instance_found(self):
