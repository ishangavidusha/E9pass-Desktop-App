// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificateStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CertificateStore on _CertificateStoreBase, Store {
  Computed<List<UserCertificate>> _$userDataComputed;

  @override
  List<UserCertificate> get userData => (_$userDataComputed ??=
          Computed<List<UserCertificate>>(() => super.userData,
              name: '_CertificateStoreBase.userData'))
      .value;
  Computed<CertificateStoreState> _$zipStateComputed;

  @override
  CertificateStoreState get zipState => (_$zipStateComputed ??=
          Computed<CertificateStoreState>(() => super.zipState,
              name: '_CertificateStoreBase.zipState'))
      .value;
  Computed<CertificateStoreState> _$certStateComputed;

  @override
  CertificateStoreState get certState => (_$certStateComputed ??=
          Computed<CertificateStoreState>(() => super.certState,
              name: '_CertificateStoreBase.certState'))
      .value;
  Computed<CertificateStoreState> _$pdfStateComputed;

  @override
  CertificateStoreState get pdfState => (_$pdfStateComputed ??=
          Computed<CertificateStoreState>(() => super.pdfState,
              name: '_CertificateStoreBase.pdfState'))
      .value;

  final _$certSearchResponsFutureAtom =
      Atom(name: '_CertificateStoreBase.certSearchResponsFuture');

  @override
  ObservableFuture<List<CertSearchRespons>> get certSearchResponsFuture {
    _$certSearchResponsFutureAtom.reportRead();
    return super.certSearchResponsFuture;
  }

  @override
  set certSearchResponsFuture(ObservableFuture<List<CertSearchRespons>> value) {
    _$certSearchResponsFutureAtom
        .reportWrite(value, super.certSearchResponsFuture, () {
      super.certSearchResponsFuture = value;
    });
  }

  final _$pdfSearchResponseFutureAtom =
      Atom(name: '_CertificateStoreBase.pdfSearchResponseFuture');

  @override
  ObservableFuture<List<PdfSearchRespons>> get pdfSearchResponseFuture {
    _$pdfSearchResponseFutureAtom.reportRead();
    return super.pdfSearchResponseFuture;
  }

  @override
  set pdfSearchResponseFuture(ObservableFuture<List<PdfSearchRespons>> value) {
    _$pdfSearchResponseFutureAtom
        .reportWrite(value, super.pdfSearchResponseFuture, () {
      super.pdfSearchResponseFuture = value;
    });
  }

  final _$certSearchResponsAtom =
      Atom(name: '_CertificateStoreBase.certSearchRespons');

  @override
  List<CertSearchRespons> get certSearchRespons {
    _$certSearchResponsAtom.reportRead();
    return super.certSearchRespons;
  }

  @override
  set certSearchRespons(List<CertSearchRespons> value) {
    _$certSearchResponsAtom.reportWrite(value, super.certSearchRespons, () {
      super.certSearchRespons = value;
    });
  }

  final _$zipCreateResponsFutureAtom =
      Atom(name: '_CertificateStoreBase.zipCreateResponsFuture');

  @override
  ObservableFuture<ZipCreateRespons> get zipCreateResponsFuture {
    _$zipCreateResponsFutureAtom.reportRead();
    return super.zipCreateResponsFuture;
  }

  @override
  set zipCreateResponsFuture(ObservableFuture<ZipCreateRespons> value) {
    _$zipCreateResponsFutureAtom
        .reportWrite(value, super.zipCreateResponsFuture, () {
      super.zipCreateResponsFuture = value;
    });
  }

  final _$zipCreateResponsAtom =
      Atom(name: '_CertificateStoreBase.zipCreateRespons');

  @override
  ZipCreateRespons get zipCreateRespons {
    _$zipCreateResponsAtom.reportRead();
    return super.zipCreateRespons;
  }

  @override
  set zipCreateRespons(ZipCreateRespons value) {
    _$zipCreateResponsAtom.reportWrite(value, super.zipCreateRespons, () {
      super.zipCreateRespons = value;
    });
  }

  final _$userCertificateAtom =
      Atom(name: '_CertificateStoreBase.userCertificate');

  @override
  List<UserCertificate> get userCertificate {
    _$userCertificateAtom.reportRead();
    return super.userCertificate;
  }

  @override
  set userCertificate(List<UserCertificate> value) {
    _$userCertificateAtom.reportWrite(value, super.userCertificate, () {
      super.userCertificate = value;
    });
  }

  final _$pdfSearchResponseAtom =
      Atom(name: '_CertificateStoreBase.pdfSearchResponse');

  @override
  List<PdfSearchRespons> get pdfSearchResponse {
    _$pdfSearchResponseAtom.reportRead();
    return super.pdfSearchResponse;
  }

  @override
  set pdfSearchResponse(List<PdfSearchRespons> value) {
    _$pdfSearchResponseAtom.reportWrite(value, super.pdfSearchResponse, () {
      super.pdfSearchResponse = value;
    });
  }

  final _$errorMsgAtom = Atom(name: '_CertificateStoreBase.errorMsg');

  @override
  String get errorMsg {
    _$errorMsgAtom.reportRead();
    return super.errorMsg;
  }

  @override
  set errorMsg(String value) {
    _$errorMsgAtom.reportWrite(value, super.errorMsg, () {
      super.errorMsg = value;
    });
  }

  final _$fullStateAtom = Atom(name: '_CertificateStoreBase.fullState');

  @override
  CertificateStoreState get fullState {
    _$fullStateAtom.reportRead();
    return super.fullState;
  }

  @override
  set fullState(CertificateStoreState value) {
    _$fullStateAtom.reportWrite(value, super.fullState, () {
      super.fullState = value;
    });
  }

  final _$zipCountAtom = Atom(name: '_CertificateStoreBase.zipCount');

  @override
  double get zipCount {
    _$zipCountAtom.reportRead();
    return super.zipCount;
  }

  @override
  set zipCount(double value) {
    _$zipCountAtom.reportWrite(value, super.zipCount, () {
      super.zipCount = value;
    });
  }

  final _$getCertificatesAsyncAction =
      AsyncAction('_CertificateStoreBase.getCertificates');

  @override
  Future<bool> getCertificates() {
    return _$getCertificatesAsyncAction.run(() => super.getCertificates());
  }

  final _$creatZipFileAsyncAction =
      AsyncAction('_CertificateStoreBase.creatZipFile');

  @override
  Future<bool> creatZipFile() {
    return _$creatZipFileAsyncAction.run(() => super.creatZipFile());
  }

  @override
  String toString() {
    return '''
certSearchResponsFuture: ${certSearchResponsFuture},
pdfSearchResponseFuture: ${pdfSearchResponseFuture},
certSearchRespons: ${certSearchRespons},
zipCreateResponsFuture: ${zipCreateResponsFuture},
zipCreateRespons: ${zipCreateRespons},
userCertificate: ${userCertificate},
pdfSearchResponse: ${pdfSearchResponse},
errorMsg: ${errorMsg},
fullState: ${fullState},
zipCount: ${zipCount},
userData: ${userData},
zipState: ${zipState},
certState: ${certState},
pdfState: ${pdfState}
    ''';
  }
}
