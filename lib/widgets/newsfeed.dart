import 'package:flutter/material.dart';

class NewsfeedCard extends StatelessWidget {
  final String userName;
  final String postContent;

  const NewsfeedCard({
    super.key,
    required this.userName,
    required this.postContent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(postContent),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.thumb_up_alt_outlined, size: 20),
                Icon(Icons.comment_outlined, size: 20),
                Icon(Icons.share_outlined, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}