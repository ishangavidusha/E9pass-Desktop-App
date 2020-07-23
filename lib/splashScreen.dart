import 'dart:async';

import 'package:e9pass_desktop/const/appConst.dart';
import 'package:e9pass_desktop/home_page.dart';
import 'package:e9pass_desktop/state/fileReadWriteStore.dart';
import 'package:e9pass_desktop/widgets/colorLoader.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppColors appColors = AppColors();
  bool startUpResult = false;
  FileReadWriteStore _fileReadWriteStore;
  Timer timer;

  void onStartApp() async {
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      startUpResult = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fileReadWriteStore ??= Provider.of<FileReadWriteStore>(context, listen: false);
  }

  @override
  void initState() {
    onStartApp();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;
    // ignore: missing_return
    return !startUpResult ? Scaffold(
      body: Stack(
        children: [
          Container(
            width: devWidth,
            height: devHeight,
            color: appColors.mainBgColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ColorLoader(
                    radius: 40,
                    dotRadius: 15,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ScalingText(
                    'Starting...',
                    style: TextStyle(
                      color: appColors.secondTextColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 18
                    ),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    ) : HomePage();
  }
}
