import 'package:e9pass_desktop/const/appConst.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class KButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final LinearGradient linearGradient;
  final Icon icon;
  final bool navigate;
  final bool busy;

  const KButton({Key key, this.text, this.onPressed, this.linearGradient, this.icon, this.navigate, this.busy}) : super(key: key);

  @override
  _KButtonState createState() => _KButtonState();
}

class _KButtonState extends State<KButton> {

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Container(
      decoration: BoxDecoration(
        gradient: appColors.buttonGradient,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: appColors.buttonShadowColor.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 2)
          )
        ]
      ),
      child: FlatButton(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: widget.icon,
            ),
            !widget.busy ? Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(color: appColors.mainTextColor),
            ) : Center(
              child: ScalingText(
                'Loading...',
                style: TextStyle(
                  color: appColors.mainTextColor
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class PanelButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final LinearGradient linearGradient;
  final Icon icon;
  final double width;
  final double height;

  const PanelButton({Key key, this.text, this.onPressed, this.linearGradient, this.icon, this.width, this.height}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: appColors.buttonGradient,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: appColors.buttonShadowColor.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 2)
          )
        ]
      ),
      child: FlatButton(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: icon,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: appColors.mainTextColor),
            )
          ],
        ),
      ),
    );
  }
}