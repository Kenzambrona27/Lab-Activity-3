import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FacebookPost extends StatefulWidget {
  const FacebookPost({super.key});

  @override
  State<FacebookPost> createState() => _FacebookPostState();
}

class _FacebookPostState extends State<FacebookPost> {
  File? _imageFile;
  Uint8List? _webImageBytes;

  String _caption = "";
  String _hashtag = "";

  // ✅ New: Text controllers for user input
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _hashtagController = TextEditingController();

  Future<void> _pickImage() async {
    try {
      if (kIsWeb) {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          withData: true,
        );
        if (result != null && result.files.single.bytes != null) {
          setState(() {
            _webImageBytes = result.files.single.bytes;
            _caption = _captionController.text.trim();
            _hashtag = _hashtagController.text.trim();
          });
        }
      } else {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _imageFile = File(pickedFile.path);
            _caption = _captionController.text.trim();
            _hashtag = _hashtagController.text.trim();
          });
        }
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Widget _getPostImageWidget() {
    if (kIsWeb && _webImageBytes != null) {
      return Image.memory(_webImageBytes!, width: double.infinity, height: 450, fit: BoxFit.cover);
    } else if (!kIsWeb && _imageFile != null) {
      return Image.file(_imageFile!, width: double.infinity, height: 450, fit: BoxFit.cover);
    } else {
      return Image.asset('assets/images/Post.jpg', width: double.infinity, height: 450, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // ✅ TextField for caption
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(
                labelText: "Caption",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // ✅ TextField for hashtag
            TextField(
              controller: _hashtagController,
              decoration: const InputDecoration(
                labelText: "Hashtag",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // ✅ Upload Button
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.upload),
              label: const Text("Upload Post Image"),
            ),

            const SizedBox(height: 20),
            _buildFacebookPost(),
          ],
        ),
      ),
    );
  }

  Widget _buildFacebookPost() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/Zambrona.jpg'),
            radius: 20,
          ),
          title: Text("Raph Kenneth Zambrona", style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("July 02, 2025", style: TextStyle(fontSize: 12)),
          trailing: Icon(Icons.more_horiz),
        ),

        // ✅ Dynamic caption and hashtag
        if (_caption.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
            child: Text(_caption),
          ),
        if (_hashtag.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(_hashtag, style: const TextStyle(color: Colors.blue)),
          ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: _getPostImageWidget(),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.favorite, color: Colors.red, size: 18),
                  Icon(Icons.thumb_up, color: Color.fromARGB(255, 57, 54, 244), size: 18),
                  Icon(Icons.emoji_emotions_sharp, color: Color.fromARGB(255, 231, 218, 32), size: 18),
                  SizedBox(width: 5),
                  Text("1,000"),
                ],
              ),
              const Text("27 Comments  12 Shares"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(thickness: 0.3, color: Colors.grey.shade400),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildButton(Icons.thumb_up_alt_outlined, " Like"),
            _buildButton(Icons.mode_comment_outlined, " Comment"),
            _buildButton(Icons.share_outlined, " Share"),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(thickness: 0.3, color: Colors.grey.shade400),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.black,
                child: ClipOval(
                  child: Image(
                    image: AssetImage('assets/images/Zambrona.jpg'),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: " Write a comment...",
                      hintStyle: const TextStyle(fontSize: 13),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(IconData icon, String label) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.grey[700]),
      label: Text(label, style: TextStyle(color: Colors.grey[700])),
    );
  }
}
