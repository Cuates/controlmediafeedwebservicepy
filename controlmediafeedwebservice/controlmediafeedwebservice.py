##
#        File: controlmediafeedwebservice.py
#     Created: 11/18/2020
#     Updated: 11/18/2020
#  Programmer: Cuates
#  Updated By: Cuates
#     Purpose: Control media feed web service
#     Version: 0.0.1 Python3
##

# Import modules
from flask import Flask, request, jsonify # Flask, request, jsonify
from flask_restful import Api # flask_restful, api
import json # json
import controlmediafeedwebserviceclass # control media feed web service class
from actionstatusclass import ActionStatusClass # action status class
from mediaaudioencodeclass import MediaAudioEncodeClass # media audio encode class
from mediadynamicrangeclass import MediaDynamicRangeClass # media dynamic range class
from mediaresolutionclass import MediaResolutionClass # media resolution class
from mediastreamsourceclass import MediaStreamSourceClass # media stream source class
from mediavideoencodeclass import MediaVideoEncodeClass # media video encode class

# Create objects
app = Flask(__name__)
api = Api(app)

# Set object
cmfwsclass = controlmediafeedwebserviceclass.ControlMediaFeedWebServiceClass()

# try to execute the command(s)
try:
  # Error handler
  @app.errorhandler(Exception)
  def errorHandling(eh):
    # Initialize variables
    messageVal = ''
    codeVal = 500

    # try to execute the command(s)
    try:
      # Set message
      messageVal = str(eh.code) + ' ' + str(eh.name) + ' ' + str(eh.description)

      # Set code
      codeVal = eh.code
    # Catch exceptions
    except Exception as e:
      # Set message
      messageVal = 'ErrorHandler'

      # Log message
      cmfwsclass._setLogger('ErrorHandler ' + str(e))

    # Return message
    return {'Status': 'Error', 'Message': messageVal, 'Count': 0, 'Result': []}, codeVal

  # Store possible methods
  validMethods = ['GET', 'POST', 'PUT', 'DELETE']

  # Before request
  @app.before_request
  def before_request_func():
    # Check if request method is in the list
    if request.method not in validMethods:
      # Return message
      return {'Status': 'Error', 'Message': 'Method invalid or not implemented', 'Count': 0, 'Result': []}, 501

  # Add resource for api web service call action status
  api.add_resource(ActionStatusClass, '/api/controlmediafeed/actionstatus', methods = validMethods)

  # Add resource for api web service call media audio encode
  api.add_resource(MediaAudioEncodeClass, '/api/controlmediafeed/mediaaudioencode', methods = validMethods)

  # Add resource for api web service call media dynamic range
  api.add_resource(MediaDynamicRangeClass, '/api/controlmediafeed/mediadynamicrange', methods = validMethods)

  # Add resource for api web service call media resolution
  api.add_resource(MediaResolutionClass, '/api/controlmediafeed/mediaresolution', methods = validMethods)

  # Add resource for api web service call media stream source
  api.add_resource(MediaStreamSourceClass, '/api/controlmediafeed/mediastreamsource', methods = validMethods)

  # Add resource for api web service call media video encode
  api.add_resource(MediaVideoEncodeClass, '/api/controlmediafeed/mediavideoencode', methods = validMethods)
# Catch exceptions
except Exception as e:
  # Log message
  cmfwsclass._setLogger('Issue executing main PY file ' + str(e))

# Run program
if __name__ == '__main__':
  # Run app
  app.run(host='127.0.0.1', port=4818, debug=True, threaded=True)