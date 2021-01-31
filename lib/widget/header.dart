import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaceCraft/GameManager/playerManager.dart';
import 'package:spaceCraft/configs/size.dart';

class Header extends StatefulWidget {
  Header({Key key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ChangeNotifierProvider(
      create: (_) => PlayerManager(),
      child: Consumer<PlayerManager>(
        builder: (ctx, data, child) => Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              EasyRichText(
                "Score: ${data.score}",
                patternList: [
                  EasyRichTextPattern(
                    targetString: "Score:",
                    matchWordBoundaries: false,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize:
                            Theme.of(context).textTheme.bodyText1.fontSize),
                  ),
                  EasyRichTextPattern(
                    targetString: "${data.score}",
                    matchWordBoundaries: false,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                    ),
                  ),
                ],
              ),
              buildLives(data),

              ///testing update
              // IconButton(
              //   icon: Icon(Icons.deck),
              //   onPressed: data.incrementScore,
              // )
            ],
          ),
        ),
      ),
    );
  }

  Row buildLives(var data) {
    List<Icon> icons = [];

    for (int i = 0; i < data.live; i++) {
      icons.add(Icon(
        Icons.favorite,
        color: Colors.red,
      ));
    }

    for (int i = data.maxLive - data.live; i > 0; i--) {
      icons.add(Icon(
        Icons.favorite,
        color: Colors.black12,
      ));
    }
    return Row(
      children: icons,
    );
  }
}
