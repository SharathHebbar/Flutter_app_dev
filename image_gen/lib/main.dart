import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img; // For image decoding

class ImageGenerationApp extends StatefulWidget {
  @override
  _ImageGenerationAppState createState() => _ImageGenerationAppState();
}

class _ImageGenerationAppState extends State<ImageGenerationApp> {
  String prompt = "Astronaut riding a horse";
  bool isLoading = false;
  img.Image? _image;

  // Define the API URL and headers
  final String apiUrl = "https://api-inference.huggingface.co/models/black-forest-labs/FLUX.1-dev";
  final Map<String, String> headers = {
    "Authorization": "Bearer hf_", // Replace with your API key
  };

  // Function to query the API and get the image
  Future<void> generateImage(String prompt) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode({
        "inputs": prompt,
      }),
    );

    if (response.statusCode == 200) {
      // If the response is successful, convert the image bytes
      setState(() {
        // Decode the image bytes into an image object using the 'image' package
        _image = img.decodeImage(Uint8List.fromList(response.bodyBytes));
        isLoading = false;
      });
    } else {
      // If the API call fails
      setState(() {
        isLoading = false;
      });
      print('Failed to generate image. Status Code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Generation App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Enter Prompt:"),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                prompt = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Prompt",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      generateImage(prompt);
                    },
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Generate Image"),
            ),
            const SizedBox(height: 20),
            _image == null
                ? Text("No image generated yet.")
                : Image.memory(Uint8List.fromList(img.encodePng(_image!))),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: ImageGenerationApp()));
