import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e9pass_desktop/const/appConst.dart';
import 'package:e9pass_desktop/models/userCertificate.dart';
import 'package:e9pass_desktop/repository/fileApiRepository.dart';
import 'package:e9pass_desktop/state/certificateStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Certificates extends StatefulWidget {
  @override
  _CertificatesState createState() => _CertificatesState();
}

class _CertificatesState extends State<Certificates> {
  AppColors appColors = AppColors();
  CertificateStore _certificateStore;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<UserCertificate> userCertificate;
  String userName;
  String appNumber;
  String arcNumber;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _certificateStore ??= CertificateStore(FileApiRepository());
  }

  Widget nameInput() {
   return Container(
     width: 200,
     child: TextFormField(
       textCapitalization: TextCapitalization.none,
       keyboardType: TextInputType.text,
       decoration: InputDecoration(
         labelText: "Name",
         hintText: "e.g kim lee hong",
         border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold
        )
       ),
       textInputAction: TextInputAction.next,
       validator: (value) {
         if (value == null || value == '') {
           return 'Name Cann\'t Be Empty';
         } else {
           return null;
         }
       },
       onChanged: (value) async {
         if (value == null || value == '') {
           _certificateStore.userCertificate = List();
         } else {
           setState(() {
            userName = value;
          });
          await _certificateStore.getOneCertificate(userName);
         }
       },
     ),
   );
  }

  Widget appNumberInput() {
   return Container(
     width: 300,
     child: TextFormField(
       textCapitalization: TextCapitalization.none,
       keyboardType: TextInputType.text,
       decoration: InputDecoration(
         labelText: "Application Number",
         hintText: "e.g 200714-6370-XXXX",
         border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold
        )
       ),
       textInputAction: TextInputAction.next,
       validator: (value) {
         if (value == null || value == '') {
           return 'Application Number Cann\'t Be Empty';
         } else {
           return null;
         }
       },
       onSaved: (newValue) => appNumber,
       onChanged: (value) {
         setState(() {
           appNumber = value;
         });
       },
     ),
   );
  }

  Widget arcNumberInput() {
   return Container(
     width: 300,
     child: TextFormField(
       textCapitalization: TextCapitalization.none,
       keyboardType: TextInputType.text,
       decoration: InputDecoration(
         labelText: "ARC Number",
         hintText: "e.g 930714-XXXXXXX",
         border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold
        )
       ),
       textInputAction: TextInputAction.next,
       validator: (value) {
         if (value == null || value == '') {
           return 'ARC Number Cann\'t Be Empty';
         } else {
           return null;
         }
       },
       onSaved: (newValue) => arcNumber,
       onChanged: (value) {
         setState(() {
           arcNumber = value;
         });
       },
     ),
   );
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
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Row(
            children: [
              nameInput(),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        Container(
          width: devWidth - 200,
          margin: EdgeInsets.symmetric(horizontal: 40,),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 150,
                child: Text(
                  'User Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        // ignore: missing_return
        Observer(builder: (_) {
          switch (_certificateStore.fullState) {
            case CertificateStoreState.initial:
              return Container(
                width: devWidth,
                height: 200,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Center(
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: appColors.secondTextColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                    ),
                  ),
                ),
              );
              break;
            case CertificateStoreState.loading:
              return Container(
                width: devWidth,
                height: 200,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
              break;
            case CertificateStoreState.loaded:
              userCertificate = _certificateStore.userData;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                width: 400,
                height: 400,
                child: ListView.builder(
                  itemCount: userCertificate.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: userCertificate[index].zipCreateStatus == true ? Colors.green.withOpacity(0.5) : Colors.blue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.all(10),
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        onPressed: () async {
                          if (userCertificate[index].certificateRespons.status == true) {
                            arcNumber = '';
                            appNumber = '';
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.INFO,
                              animType: AnimType.BOTTOMSLIDE,
                              body: Container(
                                padding: EdgeInsets.all(20),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      arcNumberInput(),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      appNumberInput(),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              btnOkText: 'OK',
                              btnOkOnPress: () async {
                                if (_formKey.currentState.validate()){
                                  bool pdfResult = await _certificateStore.getOnePdf(appNumber, index);
                                  if (pdfResult) {
                                    bool zipResult = await _certificateStore.creatOneZipFile(index, arcNumber);
                                    if (zipResult) {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title: 'Success!',
                                        desc: 'Zip Archives Created Successfully',
                                        btnOkOnPress: () {},
                                        onDissmissCallback: () {}
                                      )..show();
                                    } else {
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.ERROR,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title: 'Faild!',
                                        desc: 'Faild To Create Zip Archives',
                                        btnOkOnPress: () {},
                                        onDissmissCallback: () {}
                                      )..show();
                                    }
                                  } else {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.WARNING,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Warning!',
                                      desc: 'PDF not found \n Do you still want to creat zip?',
                                      btnOkText: 'YES',
                                      btnOkOnPress: () async {
                                        bool zipResult = await _certificateStore.creatOneZipFile(index, arcNumber);
                                        if (zipResult) {
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.SUCCES,
                                            animType: AnimType.BOTTOMSLIDE,
                                            title: 'Success!',
                                            desc: 'Zip Archives Created Successfully',
                                            btnOkOnPress: () {},
                                            onDissmissCallback: () {}
                                          )..show();
                                        } else {
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.ERROR,
                                            animType: AnimType.BOTTOMSLIDE,
                                            title: 'Faild!',
                                            desc: 'Faild To Create Zip Archives',
                                            btnOkOnPress: () {},
                                            onDissmissCallback: () {}
                                          )..show();
                                        }
                                      },
                                      btnCancelText: 'NO',
                                      btnCancelOnPress: () {

                                      },
                                      onDissmissCallback: () {}
                                    )..show();
                                  }
                                } else {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.ERROR,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'Request Cannot Be Completed!',
                                    desc: 'ARC Number or Application Number is empty',
                                    btnOkOnPress: () {},
                                    onDissmissCallback: () {}
                                  )..show();
                                }
                              },
                              onDissmissCallback: () {}
                            )..show();
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.INFO,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Request Cannot Be Completed!',
                              desc: 'Certificate File Not Found',
                              btnOkOnPress: () {},
                              onDissmissCallback: () {}
                            )..show();
                          }
                        },
                        child: Container(
                            width: 150,
                            child: Text(
                              userCertificate[index].userName,
                              style: TextStyle(),
                            )),
                      ),
                    );
                  },
                ),
              );
              break;
          }
          }),
          Container(
            child: Observer(builder: (_) {
              switch (_certificateStore.fullState) {
                case CertificateStoreState.loaded:
                  return _certificateStore.userData != null
                      ? Container(
                          width: devWidth,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
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
                                            _certificateStore.zipCount.toString(),
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
                                            _certificateStore.userCertificate.length.toString(),
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
                            ],
                          ),
                        )
                      : Container();
                default:
                  return Container();
              }
            }),
          ),
        ],
      )
    );
  }
}