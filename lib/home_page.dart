import 'dart:async';
import 'package:e9pass_desktop/bulkZipCreate.dart';
import 'package:e9pass_desktop/const/appConst.dart';
import 'package:e9pass_desktop/certificates.dart';
import 'package:e9pass_desktop/infoView.dart';
import 'package:e9pass_desktop/state/fileReadWriteStore.dart';
import 'package:e9pass_desktop/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppColors appColors = AppColors();
  PageController _controller;
  bool startUpResult = false;
  FileReadWriteStore _fileReadWriteStore;

  void onStartApp() async {
    Timer.periodic(Duration(seconds: 2), (timer) async {
      bool result = await _fileReadWriteStore.onStart();
      setState(() {
        startUpResult = result;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fileReadWriteStore ??= Provider.of<FileReadWriteStore>(context, listen: false);
  }

  @override
  void initState() {
    _controller = PageController(
      initialPage: 0
    );
    onStartApp();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: devWidth,
                height: devHeight,
                color: appColors.mainBgColor
              ),
            ),
            Positioned(
              left: 200,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: appColors.linearGradient,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 8.0,
                        blurRadius: 15.0,
                      ),
                    ]
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                width: devWidth - 200,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'E9pass Certificate Manager',
                      style: TextStyle(
                        fontSize: 28,
                        color: appColors.secondTextColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'E9pay Remittance',
                      style: TextStyle(
                        fontSize: 12,
                        color: appColors.secondTextColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  gradient: appColors.linearGradient,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 8.0,
                        blurRadius: 15.0,
                      ),
                    ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 140,
                      width: 200,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: appColors.buttonGradient,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: appColors.buttonShadowColor.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: Offset(0, 2)
                              )
                            ]
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('images/e9payLogo.png')
                          ),
                        ),
                      ),
                    ),
                    PanelButton(
                      height: 40,
                      width: 200,
                      onPressed: (){
                        _controller.jumpToPage(0);
                      },
                      text: 'Search',
                      icon: Icon(
                        Icons.search,
                        color: appColors.mainTextColor,
                      ),
                      linearGradient: appColors.buttonGradient,
                    ),
                    PanelButton(
                      height: 40,
                      width: 200,
                      onPressed: (){
                        _controller.jumpToPage(1);
                      },
                      text: 'Bulk Search',
                      icon: Icon(
                        Icons.search,
                        color: appColors.mainTextColor,
                      ),
                      linearGradient: appColors.buttonGradient,
                    ),
                    PanelButton(
                      height: 40,
                      width: 200,
                      onPressed: (){
                        _controller.jumpToPage(2);
                      },
                      text: 'Info',
                      icon: Icon(
                        Icons.info,
                        color: appColors.mainTextColor,
                      ),
                      linearGradient: appColors.buttonGradient,
                    ),
                    
                  ],
                ),
              ),
            ),
            Positioned(
              left: 200,
              top: 100,
              child: Container(
                width: devWidth - 200,
                height: devHeight - 100,
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: [
                    Certificates(),
                    ZipCreateView(),
                    InfoView()
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              width: 200,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: startUpResult ? Row(
                  children: [
                    Text(
                      'Status :',
                      style: TextStyle(
                        color: appColors.mainColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      ' Ready',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ) : Row(
                  children: [
                    Text(
                      'Status :',
                      style: TextStyle(
                        color: appColors.mainColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      ' Waiting',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}