import 'package:flutter/material.dart';

class InfoContainerWithIcon extends StatelessWidget {
  const InfoContainerWithIcon({
    super.key,
    required this.icon,
    required this.data,
  });

  final ImageIcon icon;
  final String data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          Text(data),
        ],
      ),
    );
  }
}
