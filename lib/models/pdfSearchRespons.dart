class PdfSearchRespons {
  String appNumber;
  String pdfName;

  PdfSearchRespons({this.appNumber, this.pdfName});

  PdfSearchRespons.fromJson(Map<String, dynamic> json) {
    appNumber = json['appNumber'];
    pdfName = json['pdfName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appNumber'] = this.appNumber;
    data['pdfName'] = this.pdfName;
    return data;
  }
}
