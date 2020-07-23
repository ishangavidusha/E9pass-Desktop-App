import os
import sys
from flask import Flask, request, jsonify
from flask_cors import CORS
from fileSearch import *
from sheetOpt import *
    
app = Flask(__name__)
CORS(app)

@app.route("/startUpCheck", methods=['GET'])
def onStart():
    if request.method == 'GET':
        result = startUpCheck()
        if result:
            return jsonify({"msg" : "Pass"}), 200
        else:
            return jsonify({"msg" : "Faild"}), 500

@app.route("/", methods=['GET', 'POST'])
def readWriteFile():
    if request.method == 'GET':
        result = readFromFile()
        if bool(result):
            return jsonify(result), 200
        else:
            return jsonify({"msg" : "Not Found!"}), 404
    if request.method == 'POST':
        reqData = request.get_json()
        result = writeToFile(reqData)
        if bool(result):
            return jsonify(result), 201
        else:
            return jsonify({"msg" : "Not Found!"}), 404

    
@app.route("/getcertall", methods=['GET'])
def getcertall():
    if request.method == 'GET':
        result = getAllCertList()
        if bool(result):
            return jsonify(result), 200
        else:
            return jsonify({"msg" : "Not Found!"}), 404

@app.route("/getpdfall", methods=['GET'])
def getpdfall():
    if request.method == 'GET':
        result = getPdfAll()
        if bool(result):
            return jsonify(result), 200
        else:
            return jsonify({"msg" : "Not Found!"}), 404

@app.route("/user", methods=['GET', 'POST'])
def createuser():
    if request.method == 'GET':
        return jsonify({"msg" : "E9pass Certificate File Maneger API"})
    if request.method == 'POST':
        try:
            reqData = request.get_json()
            result = creatUser(reqData)
            return jsonify(result), 201
        except:
            return jsonify({"msg" : "Bad Request!"}), 400

if __name__ == '__main__':
    app.run()
