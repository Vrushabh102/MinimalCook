import 'package:flutter/material.dart';

Widget foodItemBox(
    BuildContext context, String imageUrl, String title, int id) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        20,
      ),
      color: Colors.blueGrey,
    ),
    child: Column(
      children: [
        ClipRRect(
          // height: height * 0.3,
          // width: width ,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 160,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(
                  height: 160,
                  child: Center(
                      child: Text(
                    'Image Not found',
                    style: TextStyle(fontSize: 16),
                  )));
            },
          ),
        ),
        Expanded(
          // height: height * 0.1,
          // width: width * 0.5,
          child: Center(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                title,
                softWrap: true,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
