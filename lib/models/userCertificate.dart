class UserCertificate {
  String appNumber;
  String arcNumber;
  String userName;
  String date;
  String passStatus;
  CertificatePdfResponse certificateRespons;
  CertificatePdfResponse pdfRespons;
  bool zipCreateStatus;

  UserCertificate({
    this.appNumber,
    this.arcNumber,
    this.userName,
    this.date,
    this.passStatus,
    this.certificateRespons,
    this.pdfRespons,
    this.zipCreateStatus
  });

}

class CertificatePdfResponse {
  bool status;
  String name;

  CertificatePdfResponse({
    this.status,
    this.name
  });
}