import 'package:flutter/material.dart';

class ScrollCardWidget extends StatelessWidget {
  final List<Widget> childrenList;
  final Axis dir;
  final double height;
  final double width = 330;
  const ScrollCardWidget({
    super.key,
    required this.childrenList,
    this.dir = Axis.horizontal,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: 330,
      child: ListView(
        scrollDirection: dir,
        children: [...childrenList],
      ),
    );
  }
}
