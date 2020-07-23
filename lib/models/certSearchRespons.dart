class CertSearchRespons {
  String certificateName;
  String userName;

  CertSearchRespons({this.certificateName, this.userName});

  CertSearchRespons.fromJson(Map<String, dynamic> json) {
    certificateName = json['certificateName'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['certificateName'] = this.certificateName;
    data['userName'] = this.userName;
    return data;
  }
}