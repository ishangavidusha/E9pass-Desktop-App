import 'dart:convert';

import 'package:e9pass_desktop/models/certSearchRespons.dart';
import 'package:e9pass_desktop/models/fileReadRespons.dart';
import 'package:e9pass_desktop/models/pdfSearchRespons.dart';
import 'package:e9pass_desktop/models/userCertificate.dart';
import 'package:e9pass_desktop/models/zipCreateRespons.dart';
import 'package:http/http.dart' as http;

class FileApiRepository {
  String url = 'http://localhost:5000';

  Future<bool> startUpCheck() async {
    http.Response response;
    try {
      response = await http.get(Uri.encodeFull('$url/startUpCheck')).timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on NetworkError {
      throw NetworkError();
    }
  }

  Future<List<FileReadRespons>> readFromFile() async {
    try {
      http.Response response = await http.get(Uri.encodeFull(url));
      if (response.statusCode == 200) {
        List<FileReadRespons> fileReadRespons = (json.decode(utf8.decode(response.bodyBytes)) as List).map((data) => FileReadRespons.fromJson(data)).toList();
        return fileReadRespons.length > 0 ? fileReadRespons : null;
      } else {
        return null;
      }
    } on NetworkError {
      throw NetworkError();
    }
  }

  Future<bool> creatRecodeFile(List<UserCertificate> userCertificate) async {
    List<Map<String, dynamic>> data = [];
    Map<String, String> headers = {"Content-Type" : "application/json"};
    if (userCertificate != null && userCertificate.length > 0) {
      for (UserCertificate user in userCertificate) {
        Map<String, dynamic> jsonData = {
          "appNumber": user.appNumber,
          "arcNumber": user.arcNumber,
          "userName": user.userName,
          "passStatus": user.passStatus,
          "date": user.date,
          "zipStatus": user.zipCreateStatus ? 'Created' : 'Not Created',
          "certStatus": user.certificateRespons.status ? 'Found' : 'Not Found',
          "pdfStatus": user.pdfRespons.status ? 'Found' : 'Not Found'
        };
        data.add(jsonData);
      }
    } else {
      return false;
    }
    try {
      http.Response response = await http.post(
        Uri.encodeFull(url),
        body: jsonEncode(data),
        headers: headers
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<List<CertSearchRespons>> getCertList() async {
    try {
      http.Response response = await http.get(Uri.encodeFull('$url/getcertall'));
      if (response.statusCode == 200) {
        List<CertSearchRespons> certSearchRespons = (json.decode(utf8.decode(response.bodyBytes)) as List).map((data) => CertSearchRespons.fromJson(data)).toList();
        return certSearchRespons.length > 0 ? certSearchRespons : null;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<List<PdfSearchRespons>> getPdfList() async {
    try {
      http.Response response = await http.get(Uri.encodeFull('$url/getpdfall'));
      if (response.statusCode == 200) {
        List<PdfSearchRespons> pdfSearchRespons = (json.decode(utf8.decode(response.bodyBytes)) as List).map((data) => PdfSearchRespons.fromJson(data)).toList();
        return pdfSearchRespons.length > 0 ? pdfSearchRespons : null;
      } else {
        return null;
      }
    } on NetworkError {
      throw NetworkError;
    }
  }

  Future<ZipCreateRespons> createZipFile(UserCertificate userCertificate) async {
    Map<String, dynamic> jsonData = {
      "arcNumber" : userCertificate.arcNumber,
      "certificateName" : userCertificate.certificateRespons.name,
      "pdfName" : userCertificate.pdfRespons.name
    };
    Map<String, String> headers = {"Content-Type" : "application/json"};
    try {
      http.Response response = await http.post(
        Uri.encodeFull('$url/user'),
        body: jsonEncode(jsonData),
        headers: headers
      );
      if (response.statusCode == 201) {
        ZipCreateRespons zipCreateRespons = ZipCreateRespons.fromJson(json.decode(utf8.decode(response.bodyBytes)));
        return zipCreateRespons;
      } else {
        return null;
      }
    } on NetworkError {
      throw NetworkError();
    }
  }
}

class NetworkError extends Error {}

