import 'package:e9pass_desktop/models/fileReadRespons.dart';
import 'package:e9pass_desktop/models/userCertificate.dart';
import 'package:e9pass_desktop/repository/fileApiRepository.dart';
import 'package:mobx/mobx.dart';
part 'fileReadWriteStore.g.dart';

class FileReadWriteStore extends _FileReadWriteStoreBase with _$FileReadWriteStore {
  FileReadWriteStore(FileApiRepository fileApiRepository) : super(fileApiRepository);
}

enum FileReadWriteStoreState { initial, loading, loaded }

abstract class _FileReadWriteStoreBase with Store {
  final FileApiRepository _fileApiRepository;

  _FileReadWriteStoreBase(this._fileApiRepository);

  @observable
  ObservableFuture<List<FileReadRespons>> fileReadResponseFuture;
  @observable
  List<FileReadRespons> fileReadRespons;
  @observable
  String readErrorMsg;
  @observable
  ObservableFuture<bool> fileCreateResponsFuture;
  @observable
  bool fileCreateRespons;
  @observable
  String createMsg;
  @observable
  ObservableFuture<bool> startUpResponsFuture;
  @observable
  bool startUpRespons;
  @observable
  String startUpMsg;

  @computed
  FileReadWriteStoreState get readState {
    if (fileReadResponseFuture == null || fileReadResponseFuture.status == FutureStatus.rejected) {
      return FileReadWriteStoreState.initial;
    }
    return fileReadResponseFuture.status == FutureStatus.pending ? FileReadWriteStoreState.loading : FileReadWriteStoreState.loaded;
  }

  @computed
  FileReadWriteStoreState get createState {
    if (fileCreateResponsFuture == null || fileCreateResponsFuture.status == FutureStatus.rejected) {
      return FileReadWriteStoreState.initial;
    }
    return fileCreateResponsFuture.status == FutureStatus.pending ? FileReadWriteStoreState.loading : FileReadWriteStoreState.loaded;
  }

  @computed
  FileReadWriteStoreState get onStartState {
    if (startUpResponsFuture == null || startUpResponsFuture.status == FutureStatus.rejected) {
      return FileReadWriteStoreState.initial;
    }
    return startUpResponsFuture.status == FutureStatus.pending ? FileReadWriteStoreState.loading : FileReadWriteStoreState.loaded;
  }

  @action
  Future<bool> readFromFile() async {
    try {
      readErrorMsg = null;
      fileReadResponseFuture = ObservableFuture(_fileApiRepository.readFromFile());
      fileReadRespons = await fileReadResponseFuture;
    } catch (error) {
      readErrorMsg = error.toString();
      return false;
    }
    if (fileReadRespons == null || fileReadRespons.length < 1) {
      return false;
    } else {
      return true;
    }
  }

  @action
  Future<bool> createFile(List<UserCertificate> userCertificate) async {
    try {
      createMsg = null;
      fileCreateResponsFuture = ObservableFuture(_fileApiRepository.creatRecodeFile(userCertificate));
      fileCreateRespons = await fileCreateResponsFuture;
    } catch (error) {
      return false;
    }
    if (fileCreateRespons == false) {
      return false;
    } else {
      return true;
    }
  }

  @action
  Future<bool> onStart() async {
    try {
      readErrorMsg = null;
      startUpResponsFuture = ObservableFuture(_fileApiRepository.startUpCheck());
      startUpRespons = await startUpResponsFuture;
    } catch (error) {
      startUpMsg = error.toString();
      return false;
    }
    if (startUpRespons) {
      return true;
    } else {
      return false;
    }
  }
}