import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceCraft/SpaceCraft/provider/global_value_provider.dart';

///Player Possition UI, use consumer for Update
class PlayerOnUI extends ConsumerWidget {
  const PlayerOnUI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final playerinfo = watch(playeInfoProvider).player;
    return Positioned(
      top: playerinfo.position2d.dY,
      left: playerinfo.position2d.dX,
      child: Container(
        color: Colors.amber,
        width: playerinfo.height,
        height: playerinfo.width,
      ),
    );
  }
}
