import 'package:e9pass_desktop/models/certSearchRespons.dart';
import 'package:e9pass_desktop/models/fileReadRespons.dart';
import 'package:e9pass_desktop/models/pdfSearchRespons.dart';
import 'package:e9pass_desktop/models/userCertificate.dart';
import 'package:e9pass_desktop/models/zipCreateRespons.dart';
import 'package:e9pass_desktop/repository/fileApiRepository.dart';
import 'package:mobx/mobx.dart';
part 'certificateStore.g.dart';

class CertificateStore extends _CertificateStoreBase with _$CertificateStore {
  CertificateStore(FileApiRepository fileApiRepository) : super(fileApiRepository);
}

enum CertificateStoreState { initial, loading, loaded }

abstract class _CertificateStoreBase with Store {
  final FileApiRepository _fileApiRepository;

  _CertificateStoreBase(this._fileApiRepository);
  List<FileReadRespons> fileReadRespons;
  @observable
  ObservableFuture<List<CertSearchRespons>> certSearchResponsFuture;
  @observable
  ObservableFuture<List<PdfSearchRespons>> pdfSearchResponseFuture;
  @observable
  List<CertSearchRespons> certSearchRespons;
  @observable
  ObservableFuture<ZipCreateRespons> zipCreateResponsFuture;
  @observable
  ZipCreateRespons zipCreateRespons;
  @observable
  List<UserCertificate> userCertificate;
  @observable
  List<PdfSearchRespons> pdfSearchResponse;
  @observable
  String errorMsg;
  @observable
  CertificateStoreState fullState = CertificateStoreState.initial;
  @observable
  double zipCount = 0.0;

  @computed
  set certFullState(CertificateStoreState state) => fullState;

  @computed
  List<UserCertificate> get userData {
    return userCertificate;
  }

  @computed
  CertificateStoreState get zipState {
    if (zipCreateResponsFuture == null || zipCreateResponsFuture.status == FutureStatus.rejected) {
      return CertificateStoreState.initial;
    }
    return zipCreateResponsFuture.status == FutureStatus.pending ? CertificateStoreState.loading : CertificateStoreState.loaded;
  }

  @computed
  CertificateStoreState get certState {
    if (certSearchResponsFuture == null || certSearchResponsFuture.status == FutureStatus.rejected) {
      return CertificateStoreState.initial;
    }
    return certSearchResponsFuture.status == FutureStatus.pending ? CertificateStoreState.loading : CertificateStoreState.loaded;
  }

  @computed
  CertificateStoreState get pdfState {
    if (pdfSearchResponseFuture == null || pdfSearchResponseFuture.status == FutureStatus.rejected) {
      return CertificateStoreState.initial;
    }
    return pdfSearchResponseFuture.status == FutureStatus.pending ? CertificateStoreState.loading : CertificateStoreState.loaded;
  }

  @action
  Future<bool> getCertificates() async {
    fullState = CertificateStoreState.loading;
    try {
      errorMsg = null;
      certSearchResponsFuture = ObservableFuture(_fileApiRepository.getCertList());
      certSearchRespons = await certSearchResponsFuture;
    } on NetworkError {
      certSearchRespons = null;
      errorMsg = "Couldn't fetch Certificate";
    }
    try {
      errorMsg = null;
      pdfSearchResponseFuture = ObservableFuture(_fileApiRepository.getPdfList());
      pdfSearchResponse = await pdfSearchResponseFuture;
    } on NetworkError {
      pdfSearchResponse = null;
      errorMsg = "Couldn't fetch Pdf";
    }
    if (certSearchRespons != null && pdfSearchResponse != null) {
      userCertificate = List();
      for (FileReadRespons element in fileReadRespons) {
        bool certStatus = false;
        String certName = 'Not Found';
        bool pdfStatus = false;
        String pdfName = 'Not Found';
        for (CertSearchRespons item in certSearchRespons) {
          if (element.userName == item.userName) {
            certStatus = true;
            certName = item.certificateName;
          }
        }
        for (PdfSearchRespons item in pdfSearchResponse) {
          if (element.appNumber == item.appNumber) {
            pdfStatus = true;
            pdfName = item.pdfName;
          }
        }
        UserCertificate newUser = UserCertificate(
          appNumber: element.appNumber,
          arcNumber: element.arcNumber,
          userName: element.userName,
          date: element.date,
          passStatus: element.passStatus,
          certificateRespons: CertificatePdfResponse(
            status: certStatus,
            name: certName
          ),
          pdfRespons: CertificatePdfResponse(
            status: pdfStatus,
            name: pdfName
          ),
        );
        userCertificate.add(newUser);
      }
      fullState = CertificateStoreState.loaded;
      return true;
    } else {
      fullState = CertificateStoreState.loaded;
      return false;
    }
  }

  @action
  Future<bool> getOneCertificate(String userName) async {
    fullState = CertificateStoreState.loading;
    try {
      errorMsg = null;
      certSearchResponsFuture = ObservableFuture(_fileApiRepository.getCertList());
      certSearchRespons = await certSearchResponsFuture;
    } on NetworkError {
      certSearchRespons = null;
      errorMsg = "Couldn't fetch Certificate";
    }
    if (certSearchRespons != null) {
      userCertificate = List();
      for (CertSearchRespons item in certSearchRespons) {
        bool certStatus = false;
        String certName = 'Not Found';
        bool pdfStatus = false;
        String pdfName = 'Not Found';
        String gotUserName = '';
        if (item.userName.contains(userName)) {
          gotUserName = item.userName;
          certStatus = true;
          certName = item.certificateName;
          UserCertificate newUser = UserCertificate(
            appNumber: 'Not Set',
            arcNumber: 'Not Set',
            userName: gotUserName,
            date: 'Not Set',
            passStatus: 'Not Set',
            certificateRespons: CertificatePdfResponse(
              status: certStatus,
              name: certName
            ),
            pdfRespons: CertificatePdfResponse(
              status: pdfStatus,
              name: pdfName
            ),
          );
          userCertificate.add(newUser);
        }
      }
      fullState = CertificateStoreState.loaded;
      return true;
    } else {
      fullState = CertificateStoreState.loaded;
      return false;
    }
  }

  @action
  Future<bool> getOnePdf(String appNumber, int i) async {
    try {
      errorMsg = null;
      pdfSearchResponseFuture = ObservableFuture(_fileApiRepository.getPdfList());
      pdfSearchResponse = await pdfSearchResponseFuture;
    } on NetworkError {
      pdfSearchResponse = null;
      errorMsg = "Couldn't fetch Pdf";
    }
    if (pdfSearchResponse != null) {
      for (PdfSearchRespons item in pdfSearchResponse) {
        if (item.appNumber == appNumber) {
          userCertificate[i].pdfRespons.status = true;
          userCertificate[i].pdfRespons.name = item.pdfName;
          userCertificate[i].appNumber = appNumber;
          return true;
        }
      }
      userCertificate[i].pdfRespons.status = false;
      userCertificate[i].pdfRespons.name = 'Not Found';
      userCertificate[i].appNumber = appNumber;
      return false;
    } else {
      return false;
    }
  }

  @action
  Future<bool> creatZipFile() async {
    zipCount = 0.0;
    try {
      for (var i = 0; i < userCertificate.length; i++) {
        zipCount = i.toDouble();
        if (userCertificate[i].certificateRespons.status == true) {
          try {
            errorMsg = null;
            zipCreateResponsFuture = ObservableFuture(_fileApiRepository.createZipFile(userCertificate[i]));
            zipCreateRespons = await zipCreateResponsFuture;
            if (zipCreateRespons.zipStatus == true && zipCreateRespons.certStatus == true) {
              userCertificate[i].zipCreateStatus = true;
            } else {
              userCertificate[i].zipCreateStatus = false;
            }
          } on NetworkError {
            userCertificate[i].zipCreateStatus = false;
            print('Network Error');
          }
        } else {
          userCertificate[i].zipCreateStatus = false;
        }
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  @action
  Future<bool> creatOneZipFile(int i, String arcNumber) async {
    try {
      errorMsg = null;
      userCertificate[i].arcNumber = arcNumber;
      zipCreateResponsFuture = ObservableFuture(_fileApiRepository.createZipFile(userCertificate[i]));
      zipCreateRespons = await zipCreateResponsFuture;
      if (zipCreateRespons.zipStatus == true && zipCreateRespons.certStatus == true) {
        userCertificate[i].zipCreateStatus = true;
      } else {
        userCertificate[i].zipCreateStatus = false;
      }
    } on NetworkError {
      userCertificate[i].zipCreateStatus = false;
      print('Network Error');
      return false;
    }
    return true;
  }
}