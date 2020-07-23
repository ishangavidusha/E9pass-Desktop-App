// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fileReadWriteStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FileReadWriteStore on _FileReadWriteStoreBase, Store {
  Computed<FileReadWriteStoreState> _$readStateComputed;

  @override
  FileReadWriteStoreState get readState => (_$readStateComputed ??=
          Computed<FileReadWriteStoreState>(() => super.readState,
              name: '_FileReadWriteStoreBase.readState'))
      .value;
  Computed<FileReadWriteStoreState> _$createStateComputed;

  @override
  FileReadWriteStoreState get createState => (_$createStateComputed ??=
          Computed<FileReadWriteStoreState>(() => super.createState,
              name: '_FileReadWriteStoreBase.createState'))
      .value;
  Computed<FileReadWriteStoreState> _$onStartStateComputed;

  @override
  FileReadWriteStoreState get onStartState => (_$onStartStateComputed ??=
          Computed<FileReadWriteStoreState>(() => super.onStartState,
              name: '_FileReadWriteStoreBase.onStartState'))
      .value;

  final _$fileReadResponseFutureAtom =
      Atom(name: '_FileReadWriteStoreBase.fileReadResponseFuture');

  @override
  ObservableFuture<List<FileReadRespons>> get fileReadResponseFuture {
    _$fileReadResponseFutureAtom.reportRead();
    return super.fileReadResponseFuture;
  }

  @override
  set fileReadResponseFuture(ObservableFuture<List<FileReadRespons>> value) {
    _$fileReadResponseFutureAtom
        .reportWrite(value, super.fileReadResponseFuture, () {
      super.fileReadResponseFuture = value;
    });
  }

  final _$fileReadResponsAtom =
      Atom(name: '_FileReadWriteStoreBase.fileReadRespons');

  @override
  List<FileReadRespons> get fileReadRespons {
    _$fileReadResponsAtom.reportRead();
    return super.fileReadRespons;
  }

  @override
  set fileReadRespons(List<FileReadRespons> value) {
    _$fileReadResponsAtom.reportWrite(value, super.fileReadRespons, () {
      super.fileReadRespons = value;
    });
  }

  final _$readErrorMsgAtom = Atom(name: '_FileReadWriteStoreBase.readErrorMsg');

  @override
  String get readErrorMsg {
    _$readErrorMsgAtom.reportRead();
    return super.readErrorMsg;
  }

  @override
  set readErrorMsg(String value) {
    _$readErrorMsgAtom.reportWrite(value, super.readErrorMsg, () {
      super.readErrorMsg = value;
    });
  }

  final _$fileCreateResponsFutureAtom =
      Atom(name: '_FileReadWriteStoreBase.fileCreateResponsFuture');

  @override
  ObservableFuture<bool> get fileCreateResponsFuture {
    _$fileCreateResponsFutureAtom.reportRead();
    return super.fileCreateResponsFuture;
  }

  @override
  set fileCreateResponsFuture(ObservableFuture<bool> value) {
    _$fileCreateResponsFutureAtom
        .reportWrite(value, super.fileCreateResponsFuture, () {
      super.fileCreateResponsFuture = value;
    });
  }

  final _$fileCreateResponsAtom =
      Atom(name: '_FileReadWriteStoreBase.fileCreateRespons');

  @override
  bool get fileCreateRespons {
    _$fileCreateResponsAtom.reportRead();
    return super.fileCreateRespons;
  }

  @override
  set fileCreateRespons(bool value) {
    _$fileCreateResponsAtom.reportWrite(value, super.fileCreateRespons, () {
      super.fileCreateRespons = value;
    });
  }

  final _$createMsgAtom = Atom(name: '_FileReadWriteStoreBase.createMsg');

  @override
  String get createMsg {
    _$createMsgAtom.reportRead();
    return super.createMsg;
  }

  @override
  set createMsg(String value) {
    _$createMsgAtom.reportWrite(value, super.createMsg, () {
      super.createMsg = value;
    });
  }

  final _$startUpResponsFutureAtom =
      Atom(name: '_FileReadWriteStoreBase.startUpResponsFuture');

  @override
  ObservableFuture<bool> get startUpResponsFuture {
    _$startUpResponsFutureAtom.reportRead();
    return super.startUpResponsFuture;
  }

  @override
  set startUpResponsFuture(ObservableFuture<bool> value) {
    _$startUpResponsFutureAtom.reportWrite(value, super.startUpResponsFuture,
        () {
      super.startUpResponsFuture = value;
    });
  }

  final _$startUpResponsAtom =
      Atom(name: '_FileReadWriteStoreBase.startUpRespons');

  @override
  bool get startUpRespons {
    _$startUpResponsAtom.reportRead();
    return super.startUpRespons;
  }

  @override
  set startUpRespons(bool value) {
    _$startUpResponsAtom.reportWrite(value, super.startUpRespons, () {
      super.startUpRespons = value;
    });
  }

  final _$startUpMsgAtom = Atom(name: '_FileReadWriteStoreBase.startUpMsg');

  @override
  String get startUpMsg {
    _$startUpMsgAtom.reportRead();
    return super.startUpMsg;
  }

  @override
  set startUpMsg(String value) {
    _$startUpMsgAtom.reportWrite(value, super.startUpMsg, () {
      super.startUpMsg = value;
    });
  }

  final _$readFromFileAsyncAction =
      AsyncAction('_FileReadWriteStoreBase.readFromFile');

  @override
  Future<bool> readFromFile() {
    return _$readFromFileAsyncAction.run(() => super.readFromFile());
  }

  final _$createFileAsyncAction =
      AsyncAction('_FileReadWriteStoreBase.createFile');

  @override
  Future<bool> createFile(List<UserCertificate> userCertificate) {
    return _$createFileAsyncAction.run(() => super.createFile(userCertificate));
  }

  final _$onStartAsyncAction = AsyncAction('_FileReadWriteStoreBase.onStart');

  @override
  Future<bool> onStart() {
    return _$onStartAsyncAction.run(() => super.onStart());
  }

  @override
  String toString() {
    return '''
fileReadResponseFuture: ${fileReadResponseFuture},
fileReadRespons: ${fileReadRespons},
readErrorMsg: ${readErrorMsg},
fileCreateResponsFuture: ${fileCreateResponsFuture},
fileCreateRespons: ${fileCreateRespons},
createMsg: ${createMsg},
startUpResponsFuture: ${startUpResponsFuture},
startUpRespons: ${startUpRespons},
startUpMsg: ${startUpMsg},
readState: ${readState},
createState: ${createState},
onStartState: ${onStartState}
    ''';
  }
}
