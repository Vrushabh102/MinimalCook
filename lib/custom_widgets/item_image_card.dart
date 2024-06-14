import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.imageUrl, required this.name});
  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Column(
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Expanded(
                child: Center(
                    child: Text(
                  'Image Not found',
                  style: TextStyle(fontSize: 16),
                )),
              );
            },
          ),
          Text(
            name,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
