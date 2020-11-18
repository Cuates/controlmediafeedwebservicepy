##
#        File: actionstatusclass.py
#     Created: 11/18/2020
#     Updated: 11/18/2020
#  Programmer: Cuates
#  Updated By: Cuates
#     Purpose: Action status class
#     Version: 0.0.1 Python3
##

# Import modules
import controlmediafeedwebserviceclass # control media feed web service class
from flask import Flask, request, jsonify # Flask, request, jsonify
from flask_restful import Resource #Api # flask_restful, api, resource
import json # json

# Class
class ActionStatusClass(Resource):
  # Constructor
  def __init__(self):
    pass

  # Get method
  def get(self):
    # Initialize list, dictionary, and variables
    resultDict = {}
    returnDict = {}
    codeVal = 200

    # Create object of control media feed web service class
    cmfwsclass = controlmediafeedwebserviceclass.ControlMediaFeedWebServiceClass()

    # try to execute the command(s)
    try:
      # Store headers
      wsHead = dict(request.headers)

      # Set variable
      #reqPath = request.path

      # Check if headers were provided
      webserviceHeaderResponse = cmfwsclass._checkHeaders(wsHead)

      # Check if element exists
      if webserviceHeaderResponse.get('Status') != None:
        # Check if status is success
        if webserviceHeaderResponse['Status'] == 'Success':
          # Set list
          mandatoryParams = []

          # Check payload
          payloadResponse = cmfwsclass._checkPayload(request.method, request.args, mandatoryParams)

          # Check if element exists
          if payloadResponse.get('Status') != None:
            # Check if status is success
            if payloadResponse['Status'] == 'Success':
              # Set variable
              statusVal = 'Success'
              messageVal = 'Processed request'
              selectColumn = 'select actionnumberreturn as "Action Number", actiondescriptionreturn as "Action Description"'

              # Initialize list
              possibleParams = ['actionnumber', 'actiondescription', 'audioencode', 'dynamicrange', 'resolution', 'streamsource', 'streamdescription', 'videoencode', 'limit', 'sort']

              # Extract control media feed
              resultDict = cmfwsclass._extractControlMediaFeed('MariaDBSQLControlMedia', 'extracting', '', 'extractcontrolmediafeed', 'extractActionStatus', possibleParams, payloadResponse['Result'])
              resultDict = cmfwsclass._extractControlMediaFeed('PGSQLControlMedia', 'extracting', selectColumn, 'extractcontrolmediafeed', 'extractActionStatus', possibleParams, payloadResponse['Result'])
              resultDict = cmfwsclass._extractControlMediaFeed('MSSQLLControlMedia', 'extracting', '', 'dbo.extractControlMediaFeed', 'extractActionStatus', possibleParams, payloadResponse['Result'])
              resultDict = cmfwsclass._extractControlMediaFeed('MSSQLWControlMedia', 'extracting', '', 'dbo.extractControlMediaFeed', 'extractActionStatus', possibleParams, payloadResponse['Result'])

              # Check if there is data
              if resultDict:
                # Loop through sub elements
                for systemEntries in resultDict:
                  # Check if elements exists
                  if systemEntries.get('SError') != None:
                    # Store status value
                    statusVal = systemEntries['SError']

                    # Store message value
                    messageVal = systemEntries['SMessage']

                    # Set code
                    codeVal = 500

                    # Break out of loop
                    break

                # Check if status value is success
                if statusVal == 'Success':
                  # Store Message
                  returnDict = {'Status': statusVal, 'Message': messageVal, 'Count': len(resultDict), 'Result': resultDict}
                else:
                  # Store Message
                  returnDict = {'Status': statusVal, 'Message': messageVal, 'Count': 0, 'Result': []}
              else:
                # Store Message
                returnDict = {'Status': 'Success', 'Message': 'Processed request', 'Count': 0, 'Result': []}
            else:
              # Store Message
              returnDict = {'Status': payloadResponse['Status'], 'Message': payloadResponse['Message'], 'Count': 0, 'Result': []}

              # Store code
              codeVal = 400
          else:
            # Store Message
            returnDict = {'Status': 'Error', 'Message': 'Issue with payload check', 'Count': 0, 'Result': []}

            # Store code
            codeVal = 400
        else:
          # Store Message
          returnDict = {'Status': webserviceHeaderResponse['Status'], 'Message': webserviceHeaderResponse['Message'], 'Count': 0, 'Result': []}

          # Store code
          codeVal = 400
      else:
        # Store Message
        returnDict = {'Status': 'Error', 'Message': 'Issue with header check', 'Count': 0, 'Result': []}

        # Store code
        codeVal = 400
    # Catch exceptions
    except Exception as e:
      # Store Message
      returnDict = {'Status': 'Error', 'Message': 'GET not implemented properly', 'Count': 0, 'Result': []}

      # Log message
      cmfwsclass._setLogger('GET ' + str(e))

    # Return dictionary with code
    return returnDict, codeVal

  # Post method
  def post(self):
    # Initialize list, dictionary, and variables
    resultDict = {}
    returnDict = {}
    codeVal = 200

    # Create object of control media feed web service class
    cmfwsclass = controlmediafeedwebserviceclass.ControlMediaFeedWebServiceClass()

    # try to execute the command(s)
    try:
      # Store headers
      wsHead = dict(request.headers)

      # Set variable
      #reqPath = request.path

      # Check if headers were provided
      webserviceHeaderResponse = cmfwsclass._checkHeaders(wsHead)

      # Check if element exists
      if webserviceHeaderResponse.get('Status') != None:
        # Check if status is success
        if webserviceHeaderResponse['Status'] == 'Success':
          # Set list
          mandatoryParams = ['actionnumber', 'actiondescription']

          # Check payload
          payloadResponse = cmfwsclass._checkPayload(request.method, request.data, mandatoryParams)

          # Check if element exists
          if payloadResponse.get('Status') != None:
            # Check if status is success
            if payloadResponse['Status'] == 'Success':
              # Set variable
              statusVal = 'Success'
              messageVal = 'Processed request'

              # Initailize list
              possibleParams = ['actionnumber', 'actiondescription', 'audioencode', 'dynamicrange', 'resolution', 'streamsource', 'streamdescription', 'videoencode', 'movieinclude', 'tvinclude']
              removeParams = ['audioencode', 'dynamicrange', 'resolution', 'streamsource', 'streamdescription', 'videoencode', 'movieinclude', 'tvinclude']

              # Insert control media feed
              resultDict = cmfwsclass._insertupdatedeleteControlMediaFeed('MariaDBSQLControlMedia', 'inserting', 'insertupdatedeletecontrolmediafeed', 'insertActionStatus', possibleParams, payloadResponse['Result'], removeParams)
              resultDict = cmfwsclass._insertupdatedeleteControlMediaFeed('PGSQLControlMedia', 'inserting', 'insertupdatedeletecontrolmediafeed', 'insertActionStatus', possibleParams, payloadResponse['Result'], removeParams)
              resultDict = cmfwsclass._insertupdatedeleteControlMediaFeed('MSSQLLControlMedia', 'inserting', 'dbo.insertupdatedeleteControlMediaFeed', 'insertActionStatus', possibleParams, payloadResponse['Result'], removeParams)
              resultDict = cmfwsclass._insertupdatedeleteControlMediaFeed('MSSQLWControlMedia', 'inserting', 'dbo.insertupdatedeleteControlMediaFeed', 'insertActionStatus', possibleParams, payloadResponse['Result'], removeParams)

              # Loop through sub elements
              for systemEntries in resultDict:
                # Check if elements exists
                if systemEntries.get('SError') != None:
                  # Store status value
                  statusVal = systemEntries['SError']

                  # Store message value
                  messageVal = systemEntries['SMessage']

                  # Set code
                  codeVal = 500

                  # Break out of the loop
                  break

              if statusVal == 'Success':
                # Store Message
                returnDict = {'Status': statusVal, 'Message': messageVal, 'Count': len(resultDict), 'Result': resultDict}
              else:
                # Store Message
                returnDict = {'Status': statusVal, 'Message': messageVal, 'Count': 0, 'Result': []}
            else:
              # Store Message
              returnDict = {'Status': payloadResponse['Status'], 'Message': payloadResponse['Message'], 'Count': 0, 'Result': []}

              # Store code
              codeVal = 400
          else:
            # Store Message
            returnDict = {'Status': 'Error', 'Message': 'Issue with payload check', 'Count': 0, 'Result': []}

            # Store code
            codeVal = 400
        else:
          # Store Message
          returnDict = {'Status': webserviceHeaderResponse['Status'], 'Message': webserviceHeaderResponse['Message'], 'Count': 0, 'Result': []}
      else:
        # Store Message
        returnDict = {'Status': 'Error', 'Message': 'Issue with header check', 'Count': 0, 'Result': []}
    # Catch exceptions
    except Exception as e:
      # Store Message
      returnDict = {'Status': 'Error', 'Message': 'POST not implemented properly', 'Count': 0, 'Result': []}

      # Set code
      codeVal = 500

      # Log message
      cmfwsclass._setLogger('POST ' + str(e))

    # Return dictionary with code
    return returnDict, codeVal

  # Put method
  def put(self):
    # Initialize list, dictionary, and variables
    resultDict = {}
    returnDict = {}
    codeVal = 200

    # Create object of control media feed web service class
    cmfwsclass = controlmediafeedwebserviceclass.ControlMediaFeedWebServiceClass()

    # try to execute the command(s)
    try:
      # Store headers
      wsHead = dict(request.headers)

      ## Set variable
      #reqPath = request.path

      # Check if headers were provided
      webserviceHeaderResponse = cmfwsclass._checkHeaders(wsHead)

      # Check if element exists
      if webserviceHeaderResponse.get('Status') != None:
        # Check if status is success
        if webserviceHeaderResponse['Status'] == 'Success':
          # Set list
          mandatoryParams = ['actionnumber', 'actiondescription']

          # Check payload
          payloadResponse = cmfwsclass._checkPayload(request.method, request.data, mandatoryParams)

          # Check if element exists
          if payloadResponse.get('Status') != None:
            # Check if status is success
            if payloadResponse['Status'] == 'Success':
              # Set variable
              statusVal = 'Success'
              messageVal = 'Processed request'

              # Initailize list
              possibleParams = ['actionnumber', 'actiondescription', 'audioencode', 'dynamicrange', 'resolution', 'streamsource', 'streamdescription', 'videoencode', 'movieinclude', 'tvinclude']
              removeParams = ['audioencode', 'dynamicrange', 'resolution', 'streamsource', 'streamdescription', 'videoencode', 'movieinclude', 'tvinclude']

              # Update control media feed
              resultDict = cmfwsclass._insertupdatedeleteControlMediaFeed('MariaDBSQLControlMedia', 'updating', 'insertupdatedeletecontrolmediafeed', 'updateActionStatus', possibleParams, payloadResponse['Result'], removeParams)
              resultDict = cmfwsclass._insertupdatedeleteControlMediaFeed('PGSQLControlMedia', 'updating', 'insertupdatedeletecontrolmediafeed', 'updateActionStatus', possibleParams, payloadResponse['Result'], removeParams)
              resultDict = cmfwsclass._insertupdatedeleteControlMediaFeed('MSSQLLControlMedia', 'updating', 'dbo.insertupdatedeleteControlMediaFeed', 'updateActionStatus', possibleParams, payloadResponse['Result'], removeParams)
              resultDict = cmfwsclass._insertupdatedeleteControlMediaFeed('MSSQLWControlMedia', 'updating', 'dbo.insertupdatedeleteControlMediaFeed', 'updateActionStatus', possibleParams, payloadResponse['Result'], removeParams)

              # Loop through sub elements
              for systemEntries in resultDict:
                # Check if elements exists
                if systemEntries.get('SError') != None:
                  # Store status value
                  statusVal = systemEntries['SError']

                  # Store message value
                  messageVal = systemEntries['SMessage']

                  # Set code
                  codeVal = 500

                  # Break out of the loop
                  break

              if statusVal == 'Success':
                # Store Message
                returnDict = {'Status': statusVal, 'Message': messageVal, 'Count': len(resultDict), 'Result': resultDict}
              else:
                # Store Message
                returnDict = {'Status': statusVal, 'Message': messageVal, 'Count': 0, 'Result': []}
            else:
              # Store Message
              returnDict = {'Status': payloadResponse['Status'], 'Message': payloadResponse['Message'], 'Count': 0, 'Result': []}

              # Store code
              codeVal = 400
          else:
            # Store Message
            returnDict = {'Status': 'Error', 'Message': 'Issue with payload check', 'Count': 0, 'Result': []}

            # Store code
            codeVal = 400
        else:
          # Store Message
          returnDict = {'Status': webserviceHeaderResponse['Status'], 'Message': webserviceHeaderResponse['Message'], 'Count': 0, 'Result': []}
      else:
        # Store Message
        returnDict = {'Status': 'Error', 'Message': 'Issue with header check', 'Count': 0, 'Result': []}
    # Catch exceptions
    except Exception as e:
      # Store Message
      returnDict = {'Status': 'Error', 'Message': 'PUT not implemented properly', 'Count': 0, 'Result': []}

      # Set code
      codeVal = 500

      # Log message
      cmfwsclass._setLogger('PUT ' + str(e))

    # Return dictionary with code
    return returnDict, codeVal

  # Delete method
  def delete(self):
    # Initialize list, dictionary, and variables
    resultDict = {}
    returnDict = {}
    codeVal = 200

    # Create object of control media feed web service class
    cmfwsclass = controlmediafeedwebserviceclass.ControlMediaFeedWebServiceClass()

    # try to execute the command(s)
    try:
      # Store headers
      wsHead = dict(request.headers)

      ## Set variable
      #reqPath = request.path

      # Check if headers were provided
      webserviceHeaderResponse = cmfwsclass._checkHeaders(wsHead)

      # Check if element exists
      if webserviceHeaderResponse.get('Status') != None:
        # Check if status is success
        if webserviceHeaderResponse['Status'] == 'Success':
          # Set list
          mandatoryParams = ['actionnumber']

          # Check payload
          payloadResponse = cmfwsclass._checkPayload(request.method, request.data, mandatoryParams)

          # Check if element exists
          if payloadResponse.get('Status') != None:
            # Check if status is success
            if payloadResponse['Status'] == 'Success':
              # Set variable
              statusVal = 'Success'
              messageVal = 'Processed request'

              # Initailize list
              possibleParams = ['actionnumber', 'actiondescription', 'audioencode', 'dynamicrange', 'resolution', 'streamsource', 'streamdescription', 'videoencode', 'movieinclude', 'tvinclude']
              removeParams = ['actiondescription', 'audioencode', 'dynamicrange', 'resolution', 'streamsource', 'streamdescription', 'videoencode', 'movieinclude', 'tvinclude']

              # Delete control media feed
              resultDict = cmfwsclass._insertupdatedeleteControlMediaFeed('MariaDBSQLControlMedia', 'deleting', 'insertupdatedeletecontrolmediafeed', 'deleteActionStatus', possibleParams, payloadResponse['Result'], removeParams)
              resultDict = cmfwsclass._insertupdatedeleteControlMediaFeed('PGSQLControlMedia', 'deleting', 'insertupdatedeletecontrolmediafeed', 'deleteActionStatus', possibleParams, payloadResponse['Result'], removeParams)
              resultDict = cmfwsclass._insertupdatedeleteControlMediaFeed('MSSQLLControlMedia', 'deleting', 'dbo.insertupdatedeleteControlMediaFeed', 'deleteActionStatus', possibleParams, payloadResponse['Result'], removeParams)
              resultDict = cmfwsclass._insertupdatedeleteControlMediaFeed('MSSQLWControlMedia', 'deleting', 'dbo.insertupdatedeleteControlMediaFeed', 'deleteActionStatus', possibleParams, payloadResponse['Result'], removeParams)

              # Loop through sub elements
              for systemEntries in resultDict:
                # Check if elements exists
                if systemEntries.get('SError') != None:
                  # Store status value
                  statusVal = systemEntries['SError']

                  # Store message value
                  messageVal = systemEntries['SMessage']

                  # Set code
                  codeVal = 500

                  # Break out of the loop
                  break

              if statusVal == 'Success':
                # Store Message
                returnDict = {'Status': statusVal, 'Message': messageVal, 'Count': len(resultDict), 'Result': resultDict}
              else:
                # Store Message
                returnDict = {'Status': statusVal, 'Message': messageVal, 'Count': 0, 'Result': []}
            else:
              # Store Message
              returnDict = {'Status': payloadResponse['Status'], 'Message': payloadResponse['Message'], 'Count': 0, 'Result': []}

              # Store code
              codeVal = 400
          else:
            # Store Message
            returnDict = {'Status': 'Error', 'Message': 'Issue with payload check', 'Count': 0, 'Result': []}

            # Store code
            codeVal = 400
        else:
          # Store Message
          returnDict = {'Status': webserviceHeaderResponse['Status'], 'Message': webserviceHeaderResponse['Message'], 'Count': 0, 'Result': []}
      else:
        # Store Message
        returnDict = {'Status': 'Error', 'Message': 'Issue with header check', 'Count': 0, 'Result': []}
    # Catch exceptions
    except Exception as e:
      # Store Message
      returnDict = {'Status': 'Error', 'Message': 'DELETE not implemented properly', 'Count': 0, 'Result': []}

      # Set code
      codeVal = 500

      # Log message
      cmfwsclass._setLogger('DELETE ' + str(e))

    # Return dictionary with code
    return returnDict, codeVal