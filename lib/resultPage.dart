import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e9pass_desktop/const/appConst.dart';
import 'package:e9pass_desktop/models/fileReadRespons.dart';
import 'package:e9pass_desktop/models/userCertificate.dart';
import 'package:e9pass_desktop/repository/fileApiRepository.dart';
import 'package:e9pass_desktop/state/certificateStore.dart';
import 'package:e9pass_desktop/state/fileReadWriteStore.dart';
import 'package:e9pass_desktop/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ResultPage extends StatefulWidget {
  final List<FileReadRespons> fileReadRespons;

  const ResultPage({Key key, this.fileReadRespons}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  CertificateStore _certificateStore;
  AppColors appColors = AppColors();
  List<UserCertificate> userCertificate;
  bool _searchResult = false;
  FileReadWriteStore _fileReadWriteStore;
  bool filesCreated = false;
  bool pageBusy = false;

  void getData() async {
    bool result = await _certificateStore.getCertificates();
    setState(() {
      _searchResult = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _certificateStore = CertificateStore(FileApiRepository());
    _fileReadWriteStore = FileReadWriteStore(FileApiRepository());
    _certificateStore.fileReadRespons = widget.fileReadRespons;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appColors.mainBgColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                // ignore: missing_return
                Observer(builder: (_) {
                  switch (_certificateStore.fullState) {
                    case CertificateStoreState.initial:
                      return Container(
                        width: devWidth,
                        height: devHeight - 200,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: Center(
                          child: Text(
                            'Ready',
                            style: TextStyle(
                              color: appColors.secondTextColor,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    case CertificateStoreState.loading:
                      return Container(
                        width: devWidth,
                        height: devHeight - 200,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: Center(
                          child: ScalingText(
                            'Searching...',
                            style: TextStyle(
                              color: appColors.secondTextColor,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    case CertificateStoreState.loaded:
                      if (!_searchResult) {
                        return Container(
                          width: devWidth,
                          height: devHeight - 200,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Center(
                            child: Text(
                              'Files Not Found\nMake Sure That Files is in the Right Directory',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: appColors.secondTextColor,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      } else {
                        userCertificate = _certificateStore.userData;
                        return Container(
                          width: devWidth,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: DataTable(
                            columns: [
                              DataColumn(
                                label: Text(
                                  'Application Number',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'ARC / Pasport Number',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Pass Status',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Certificate',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'PDF',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Zipping Status',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                            rows: userCertificate.map((user) => DataRow(
                              selected: false,
                              cells: [
                                DataCell(
                                  Text(user.appNumber),
                                ),
                                DataCell(
                                  Text(user.arcNumber),
                                ),
                                DataCell(
                                  Text(user.userName),
                                ),
                                DataCell(
                                  Text(user.passStatus),
                                ),
                                DataCell(
                                  user.certificateRespons.status != null ? user.certificateRespons.status == true ? Text(
                                    'Found',
                                    style: TextStyle(
                                      color: Colors.green
                                    ),
                                  ) : Text(
                                    'Not Found',
                                    style: TextStyle(
                                      color: Colors.redAccent
                                    ),
                                  ) : Text(
                                    'Not Found',
                                    style: TextStyle(
                                      color: Colors.redAccent
                                    ),
                                  ),
                                ),
                                DataCell(
                                  user.pdfRespons.status != null ? user.pdfRespons.status == true ? Text(
                                    'Found',
                                    style: TextStyle(
                                      color: Colors.green
                                    ),
                                  ) : Text(
                                    'Not Found',
                                    style: TextStyle(
                                      color: Colors.redAccent
                                    ),
                                  ) : Text(
                                    'Not Found',
                                    style: TextStyle(
                                      color: Colors.redAccent
                                    ),
                                  ),
                                ),
                                DataCell(
                                  user.zipCreateStatus != null ? user.zipCreateStatus == true ? Text(
                                    'Created',
                                    style: TextStyle(
                                      color: Colors.green
                                    ),
                                  ) : Text(
                                    'Failed',
                                    style: TextStyle(
                                      color: Colors.redAccent
                                    ),
                                  ) : Text(
                                    'Unavailable',
                                    style: TextStyle(
                                      color: Colors.redAccent
                                    ),
                                  ),
                                ),
                              ]
                            )).toList(),
                          ),
                        );
                      }
                  }
                }),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Observer(builder: (_) {
              switch (_certificateStore.fullState) {
                case CertificateStoreState.loaded:
                  return _certificateStore.userData != null
                      ? Container(
                          width: devWidth,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white24,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                // ignore: missing_return
                                child: Observer(builder: (_) {
                                  switch (_certificateStore.zipState) {
                                    case CertificateStoreState.initial:
                                      return Text(
                                        'Ready',
                                        style: TextStyle(
                                            color: appColors.secondTextColor,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 18),
                                      );
                                    case CertificateStoreState.loading:
                                      return Row(
                                        children: [
                                          ScalingText(
                                            'Creating...',
                                            style: TextStyle(
                                              color: appColors.secondTextColor,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            _certificateStore.zipCount
                                                .toString(),
                                            style: TextStyle(
                                              color: appColors.secondTextColor,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            '/',
                                            style: TextStyle(
                                              color: appColors.secondTextColor,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            _certificateStore
                                                .userCertificate.length
                                                .toString(),
                                            style: TextStyle(
                                              color: appColors.secondTextColor,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      );
                                    case CertificateStoreState.loaded:
                                      return Text(
                                        'Done',
                                        style: TextStyle(
                                            color: appColors.secondTextColor,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 18),
                                      );
                                  }
                                }),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 40,
                                    child: KButton(
                                      text: 'Save Result',
                                      linearGradient: appColors.buttonGradient,
                                      busy: false,
                                      navigate: false,
                                      icon: Icon(
                                        Icons.save,
                                        color: appColors.mainTextColor,
                                      ),
                                      onPressed: () async {
                                        if (filesCreated) {
                                          bool result =
                                              await _fileReadWriteStore
                                                  .createFile(userCertificate);
                                          if (result) {
                                            AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.SUCCES,
                                                animType: AnimType.BOTTOMSLIDE,
                                                title: 'Success',
                                                desc:
                                                    'Excel File Created Successfully',
                                                btnOkOnPress: () {},
                                                onDissmissCallback: () {})
                                              ..show();
                                          } else {
                                            AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.ERROR,
                                                animType: AnimType.BOTTOMSLIDE,
                                                title: 'Faild',
                                                desc:
                                                    'Faild To Create Excel File',
                                                btnOkOnPress: () {},
                                                onDissmissCallback: () {})
                                              ..show();
                                          }
                                        } else {
                                          AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.INFO,
                                              animType: AnimType.BOTTOMSLIDE,
                                              title: 'Notice',
                                              desc:
                                                  'Zip Files Not Created Yet!',
                                              btnOkOnPress: () {},
                                              onDissmissCallback: () {})
                                            ..show();
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 250,
                                    height: 40,
                                    child: KButton(
                                      text: 'Create Zip Archives',
                                      linearGradient: appColors.buttonGradient,
                                      busy: false,
                                      navigate: false,
                                      icon: Icon(
                                        Icons.create,
                                        color: appColors.mainTextColor,
                                      ),
                                      onPressed: !pageBusy
                                          ? () async {
                                              bool result =
                                                  await _certificateStore
                                                      .creatZipFile();
                                              setState(() {
                                                filesCreated = result;
                                              });
                                              if (result) {
                                                AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.SUCCES,
                                                    animType:
                                                        AnimType.BOTTOMSLIDE,
                                                    title: 'Success',
                                                    desc:
                                                        'Zip Archives Created Successfully',
                                                    btnOkOnPress: () {},
                                                    onDissmissCallback: () {})
                                                  ..show();
                                              } else {
                                                AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.ERROR,
                                                    animType:
                                                        AnimType.BOTTOMSLIDE,
                                                    title: 'Faild',
                                                    desc:
                                                        'Faild To Create Zip Archives',
                                                    btnOkOnPress: () {},
                                                    onDissmissCallback: () {})
                                                  ..show();
                                              }
                                              setState(() {
                                                userCertificate =
                                                    _certificateStore.userData;
                                              });
                                            }
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container();
                default:
                  return Container();
              }
            }),
          ),
          Positioned(
            height: 50,
            child: Container(
              width: devWidth,
              height: 50,
              decoration:
                  BoxDecoration(gradient: appColors.buttonGradient, boxShadow: [
                BoxShadow(
                    color: appColors.buttonShadowColor.withOpacity(0.6),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 2))
              ]),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Certificate Search Result',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
