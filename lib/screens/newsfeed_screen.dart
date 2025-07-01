import 'package:flutter/material.dart';
import '../widgets/newsfeed.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Feed')),
      body: ListView(
        children: const [
          NewsfeedCard(userName: 'Sebastian Onnagan', postContent: 'Ang pogi mo sa profile mo pre'),
          NewsfeedCard(userName: 'Elsi Delacruz', postContent: 'Nice photo'),
        ],
      ),
    );
  }
}