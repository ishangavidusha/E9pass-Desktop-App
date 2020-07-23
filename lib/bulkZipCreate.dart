import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e9pass_desktop/const/appConst.dart';
import 'package:e9pass_desktop/models/fileReadRespons.dart';
import 'package:e9pass_desktop/resultPage.dart';
import 'package:e9pass_desktop/state/fileReadWriteStore.dart';
import 'package:e9pass_desktop/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class ZipCreateView extends StatefulWidget {
  @override
  _ZipCreateViewState createState() => _ZipCreateViewState();
}

class _ZipCreateViewState extends State<ZipCreateView> {
  AppColors appColors = AppColors();
  FileReadWriteStore _fileReadWriteStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fileReadWriteStore ??=
        Provider.of<FileReadWriteStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;
    return Container(
      width: devWidth - 200,
      height: devHeight - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: devWidth - 200,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  height: 40,
                  child: KButton(
                    text: 'Get Exel Data',
                    linearGradient: appColors.buttonGradient,
                    busy: false,
                    navigate: false,
                    icon: Icon(
                      Icons.data_usage,
                      color: appColors.mainTextColor,
                    ),
                    onPressed: () async {
                      bool result = await _fileReadWriteStore.readFromFile();
                      if (!result) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.INFO,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'File Not Found',
                          desc: 'Make Sure That File is in the Right Directory, The File Name is Correct and File Not Empty',
                          btnOkOnPress: () {
                            _fileReadWriteStore.fileReadResponseFuture = null;
                            _fileReadWriteStore.fileReadRespons = null;
                          },
                          onDissmissCallback: () {
                            _fileReadWriteStore.fileReadResponseFuture = null;
                            _fileReadWriteStore.fileReadRespons = null;
                          }
                        )..show();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: devWidth - 200,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 150,
                  child: Text(
                    'Application Number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  width: 150,
                  child: Text(
                    'ARC / Pasport Number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  width: 150,
                  child: Text(
                    'User Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  width: 150,
                  child: Text(
                    'Pass Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  width: 150,
                  child: Text(
                    'Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                )
              ],
            ),
          ),
          Observer(
            // ignore: missing_return
            builder: (BuildContext context) {
              switch (_fileReadWriteStore.readState) {
                case FileReadWriteStoreState.initial:
                  return Container(
                    width: devWidth - 200,
                    height: devHeight - 300,
                    child: Center(
                      child: Text(
                        'No File Selected',
                        style: TextStyle(
                          color: appColors.mainColor,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 18
                        ),
                      ),
                    ),
                  );
                case FileReadWriteStoreState.loading:
                  return Container(
                    width: devWidth - 200,
                    height: devHeight - 300,
                    child: Center(
                      child: ScalingText(
                        'Searching...',
                        style: TextStyle(
                            color: appColors.secondTextColor,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 18
                          ),
                      )
                    )
                  );
                case FileReadWriteStoreState.loaded:
                 return Column(
                   children: [
                     Container(
                      width: devWidth - 200,
                      height: devHeight - 300,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: ListView.builder(
                        itemCount: _fileReadWriteStore?.fileReadRespons == null ? 0 : _fileReadWriteStore.fileReadRespons.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: appColors.mainColor.withOpacity(0.2)
                                ),
                              )
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(
                                    _fileReadWriteStore.fileReadRespons[index].appNumber
                                  )
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    _fileReadWriteStore.fileReadRespons[index].arcNumber
                                  )
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    _fileReadWriteStore.fileReadRespons[index].userName
                                  )
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    _fileReadWriteStore.fileReadRespons[index].passStatus
                                  )
                                )
                                ,
                                SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    _fileReadWriteStore.fileReadRespons[index].date
                                  )
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: devWidth - 200,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            child: Text(
                              'Total : ${_fileReadWriteStore.fileReadRespons.length.toString()}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            width: 200,
                            height: 40,
                            child: KButton(
                              text: 'Search Files',
                              linearGradient: appColors.buttonGradient,
                              busy: false,
                              navigate: false,
                              icon: Icon(
                                Icons.search,
                                color: appColors.mainTextColor,
                              ),
                              onPressed: () async {
                                List<FileReadRespons> fileReadRespons = _fileReadWriteStore.fileReadRespons;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ResultPage(fileReadRespons: fileReadRespons,))
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                   ],
                 );
              }
          })
        ],
      ),
    );
  }
}
