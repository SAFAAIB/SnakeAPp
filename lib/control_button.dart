import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snake_app/utils/size_config.dart';

class ControlButton extends StatelessWidget {
  Function onPressed;
  Icon icon;

  ControlButton({this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Opacity(
      opacity: 0.5,
      child: Container(
        width: SizeConfig.scaleWidth(80),
        height: SizeConfig.scaleHeight(80),
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 0,
            onPressed: this.onPressed,
            child: this.icon,
            backgroundColor: Color(0XFF810B44),

          ),
        ),
      ),
    );
  }
}
