import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snake_app/game_page.dart';
import 'package:snake_app/utils/size_config.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => StartGame()));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0XFFFFDFDC),
      body: Center(
        child: Text(
          'SNAKE GAME',
          style: TextStyle(
              fontFamily: 'Itim',
              fontSize: SizeConfig.scaleTextFont(50),
              fontWeight: FontWeight.bold,
              color: Color(0XFF810B44)),
        ),
      ),
    );
  }
}

class StartGame extends StatefulWidget {
  @override
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFFFDFDC),
        body: Center(
          child: Container(
            height: SizeConfig.scaleHeight(70),
            width: SizeConfig.scaleWidth(200),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return GamePage();
                  }));
                },
                child: Text('START' , style: TextStyle(fontSize: SizeConfig.scaleTextFont(35),fontFamily: 'Itim'),),
                
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0XFF810B44)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ))),
          ),
        ));
  }
}
