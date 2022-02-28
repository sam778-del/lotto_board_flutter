import 'package:flutter/material.dart';
import 'package:lotto_board/utils/hexToColor.dart';

class Button extends StatelessWidget {
  final Widget child;
  final VoidCallback onClick;
  const Button({Key? key, required this.child, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.black12),
      child: Material(
        color: hexToColor("#41aa5e"),
        child: InkWell(
            onTap: onClick,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}