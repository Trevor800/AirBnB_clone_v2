#!/usr/bin/python3
''' Test suite for the console'''

import os
import sys
from unittest.mock import create_autospec
from io import StringIO
from console import HBNBCommand
import os
import models
import unittest


class TestCreateCommand(unittest.TestCase):

    def setUp(self):
        self.cmd = HBNBCommand()
        self.mock_stdout = StringIO()
        storage.reset()

    def tearDown(self):
        self.mock_stdout.close()

    @patch('sys.stdout', new_callable=StringIO)
    def test_create_base_model_with_valid_params(self, mock_stdout):
        with patch('models.storage.save') as mock_save:
            self.cmd.onecmd("create BaseModel name=\"Test Model\" value=42")
            expected_output = "[BaseModel] ("
            self.assertIn(expected_output, mock_stdout.getvalue())
            self.assertTrue(mock_save.called)

    @patch('sys.stdout', new_callable=StringIO)
    def test_create_missing_class_name(self, mock_stdout):
        self.cmd.onecmd("create")
        expected_output = "** class name missing **\n"
        self.assertEqual(expected_output, mock_stdout.getvalue())

    @patch('sys.stdout', new_callable=StringIO)
    def test_create_with_invalid_class(self, mock_stdout):
        self.cmd.onecmd("create InvalidClass name=\"Test Model\" value=42")
        expected_output = "** class doesn't exist **\n"
        self.assertEqual(expected_output, mock_stdout.getvalue())

    @patch('sys.stdout', new_callable=StringIO)
    def test_create_with_string_value(self, mock_stdout):
        with patch('models.storage.save') as mock_save:
            self.cmd.onecmd("create BaseModel name=\"Test Model\" value=\"Test Value\"")
            expected_output = "[BaseModel] ("
            self.assertIn(expected_output, mock_stdout.getvalue())
            self.assertTrue(mock_save.called)

    @patch('sys.stdout', new_callable=StringIO)
    def test_create_with_float_value(self, mock_stdout):
        with patch('models.storage.save') as mock_save:
            self.cmd.onecmd("create BaseModel name=\"Test Model\" value=3.14")
            expected_output = "[BaseModel] ("
            self.assertIn(expected_output, mock_stdout.getvalue())
            self.assertTrue(mock_save.called)

    # Add more test cases to cover different scenarios

if __name__ == '__main__':
    unittest.main()
