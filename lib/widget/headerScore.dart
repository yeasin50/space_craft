import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaceCraft/GameManager/playerManager.dart';

class HeaderScore extends StatelessWidget {
  HeaderScore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerManager>(
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
                      fontSize: Theme.of(context).textTheme.bodyText1.fontSize),
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

            // /testing update
            // IconButton(
            //   icon: Icon(Icons.deck),
            //   onPressed: data.incrementScore,
            // )
          ],
        ),
      ),
    );
  }
}
