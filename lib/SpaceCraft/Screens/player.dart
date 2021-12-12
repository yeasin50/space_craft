import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Player Possition UI, use consumer for Update
class PlayerOnUI extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final playerinfo = ref.watch(playeInfoProvider).player;
    return Positioned(
      // top: playerinfo.position2d.dY,
      // left: playerinfo.position2d.dX,
      child: Container(
        color: Colors.amber,
        // width: playerinfo.height,
        // height: playerinfo.width,
      ),
    );
  }
}
