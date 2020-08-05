import os
import sys
import shutil
import pathlib
import zipfile
import string
from pdf_compressor import compress

E9PASS = 'Desktop\\E9pass'
E9PASS_USER = 'Desktop\\E9pass\\USER'
E9PASS_PDF = 'Desktop\\E9pass\\PDF'
E9PASS_BACKUP = 'Desktop\\E9pass\\PASS_BACKUP'

def checkDir(certDir):
    home = os.environ['USERPROFILE']
    dirPath = os.path.join(home, certDir)
    if os.path.isdir(dirPath):
        return dirPath
    else:
        os.makedirs(dirPath)
        return dirPath

def startUpCheck():
    try:
        checkDir(E9PASS)
        checkDir(E9PASS_USER)
        checkDir(E9PASS_PDF)
        return True
    except:
        return False

def getAllCertList():
    checkDir(E9PASS_USER)
    home = os.environ['USERPROFILE']
    userDir = os.path.join(home, E9PASS_USER)
    certList = os.listdir(userDir)
    userCertificateList = []
    for item in certList:
        certificate = {}
        certificate["certificateName"] = item
        userName = item.split('=')
        userName = userName[1].split(',')
        userName = userName[0]
        certificate["userName"] = userName
        userCertificateList.append(certificate)
    if len(userCertificateList) > 0:
        return userCertificateList
    else:
        return None

def getPdfAll():
    checkDir(E9PASS_PDF)
    home = os.environ['USERPROFILE']
    pdfDir = os.path.join(home, E9PASS_PDF)
    pdfList = os.listdir(pdfDir)
    userPdfList = []
    for item in pdfList:
        pdf = {}
        try:
            nameList = item.split('-')
            if len(nameList) >= 3:
                if len(nameList[-3]) == 6 and len(nameList[-2]) == 4 and len(nameList[-1]) == 8:
                    appNumber = nameList[-3] + '-' + nameList[-2] + '-' + nameList[-1].split('.')[0]
                    pdf["pdfName"] = item
                    pdf["appNumber"] = appNumber
                    userPdfList.append(pdf)
        except:
            pass
    if len(userPdfList) > 0:
        return userPdfList
    else:
        return None

def copyAndOverwrite(from_path, to_path):
    if os.path.exists(to_path):
        shutil.rmtree(to_path)
    shutil.copytree(from_path, to_path)

def creatUser(userDetails):
    response = {}
    home = os.environ['USERPROFILE']
    checkDir(E9PASS_BACKUP)
    certificateFilesPath = os.path.join(home, E9PASS_USER)
    pdfFilesPath = os.path.join(home, E9PASS_PDF)
    backUpDir = os.path.join(home, E9PASS_BACKUP)
    try:
        arcNumber = userDetails["arcNumber"]
        certificateName = userDetails["certificateName"]
        table = str.maketrans('', '', string.punctuation)
        folderName = arcNumber.translate(table)
        path = pathlib.Path(os.path.join(backUpDir, folderName + '\\NPKI\\KICA\\USER\\' + certificateName))
        path.mkdir(parents=True, exist_ok=True)
        destination = os.path.join(backUpDir, folderName + '\\NPKI\\KICA\\USER\\' + certificateName)
        source = os.path.join(certificateFilesPath, certificateName)
        copyAndOverwrite(source, destination)
        response["certStatus"] = True
        response["certMsg"] = 'Success'
        try:
            pdfName = userDetails["pdfName"]
            source = os.path.join(pdfFilesPath, pdfName)
            destination = os.path.join(backUpDir, os.path.join(folderName, pdfName))
            result = None
            result = compress(source, destination, power=2)
            while result is None:
                pass
            response["pdfStatus"] = result
            response["pdfMsg"] = 'PDF Compress Status'
        except:
            response["pdfStatus"] = False
            response["pdfMsg"] = 'Unable to copy Pdf!'
        try:
            os.chdir(backUpDir)
            table = str.maketrans('', '', string.punctuation)
            fileName = arcNumber.translate(table)
            result = shutil.make_archive(fileName, 'zip', base_dir=folderName)
            if bool(result):
                shutil.rmtree(folderName)
            response["zipStatus"] = True
            response["zipMsg"] = 'Success'
            return response
        except:
            response["zipStatus"] = False
            response["zipMsg"] = 'Unable to Create ZIP Archive'
            return response
    except OSError as err:
        print(err)
        response["certStatus"] = False
        response["certMsg"] = 'Unable to copy Certificate!'
        return response

result = getPdfAll()
for item in result:
    print(item['appNumber'])