import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaceCraft/GameManager/playerManager.dart';
import 'package:spaceCraft/configs/size.dart';

class HealthMeter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<PlayerManager>(
      builder: (ctx, data, ch) => Container(
         margin: EdgeInsets.symmetric( vertical: 25),
        
        child: LinearProgressIndicator(
          value:  data.health * .01,
          backgroundColor: Colors.yellow,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      ),
    );
  }
}
