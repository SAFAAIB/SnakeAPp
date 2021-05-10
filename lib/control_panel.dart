import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snake_app/control_button.dart';
import 'package:snake_app/game_page.dart';
import 'package:snake_app/utils/size_config.dart';

class ControlPanel extends StatelessWidget {
  Function(Direction direction) onTapped;

  ControlPanel({this.onTapped});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Positioned(
      left: SizeConfig.scaleWidth(0),
      right: SizeConfig.scaleWidth(0),
      bottom: SizeConfig.scaleWidth(50),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: Container()),
                ControlButton(
                  onPressed: () {
                    onTapped(Direction.left);
                  },
                  icon: Icon(Icons.arrow_left),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ControlButton(
                  onPressed: () {
                    onTapped(Direction.up);
                  },
                  icon: Icon(Icons.arrow_drop_up),
                ),
                SizedBox(height:SizeConfig.scaleHeight(80) ,),
                ControlButton(
                  onPressed: () {
                    onTapped(Direction.down);
                  },
                  icon: Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                ControlButton(
                  onPressed: () {
                    onTapped(Direction.right);
                  },
                  icon: Icon(Icons.arrow_right),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
