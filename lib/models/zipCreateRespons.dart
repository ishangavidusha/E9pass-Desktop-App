class ZipCreateRespons {
  String certMsg;
  bool certStatus;
  String pdfMsg;
  bool pdfStatus;
  String zipMsg;
  bool zipStatus;

  ZipCreateRespons(
      {this.certMsg,
      this.certStatus,
      this.pdfMsg,
      this.pdfStatus,
      this.zipMsg,
      this.zipStatus});

  ZipCreateRespons.fromJson(Map<String, dynamic> json) {
    certMsg = json['certMsg'];
    certStatus = json['certStatus'];
    pdfMsg = json['pdfMsg'];
    pdfStatus = json['pdfStatus'];
    zipMsg = json['zipMsg'];
    zipStatus = json['zipStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['certMsg'] = this.certMsg;
    data['certStatus'] = this.certStatus;
    data['pdfMsg'] = this.pdfMsg;
    data['pdfStatus'] = this.pdfStatus;
    data['zipMsg'] = this.zipMsg;
    data['zipStatus'] = this.zipStatus;
    return data;
  }
}