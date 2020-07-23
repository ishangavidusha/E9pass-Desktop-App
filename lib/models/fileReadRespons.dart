class FileReadRespons {
  String appNumber;
  String arcNumber;
  String date;
  String passStatus;
  String userName;

  FileReadRespons(
      {this.appNumber,
      this.arcNumber,
      this.date,
      this.passStatus,
      this.userName});

  FileReadRespons.fromJson(Map<String, dynamic> json) {
    appNumber = json['appNumber'];
    arcNumber = json['arcNumber'];
    date = json['date'];
    passStatus = json['passStatus'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appNumber'] = this.appNumber;
    data['arcNumber'] = this.arcNumber;
    data['date'] = this.date;
    data['passStatus'] = this.passStatus;
    data['userName'] = this.userName;
    return data;
  }
}