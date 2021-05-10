import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './GameManager/playerManager.dart';
import './GameManager/uiManager.dart';
import './home.dart';
import './tester.dart';
import './widget/rives/rive_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PlayerManager()),
        ChangeNotifierProvider.value(value: UIManager()),
      ],
      child: Consumer<PlayerManager>(
        builder: (ctx, data, ch) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Scaffold(
            // body: HomeScreen(),
            // body: PlayerRive(),
            // body: HeaderLive(),
            // body: Explosion(),
            // body: PlayerRive(),
            body: Tester(),
          ),
        ),
      ),
    );
  }
}
