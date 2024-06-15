import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.color});
  final String imageUrl;
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Expanded(
                  child: Center(
                      child: Text(
                    'Image Not found',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  )),
                );
              },
            ),
          ),
          Text(
            name,
            style: TextStyle(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
