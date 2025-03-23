import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Correct import for file_picker

class IAmarksView extends StatelessWidget {
  const IAmarksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("IA Marks")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please refer to the demo Excel file below and upload your own.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Demo File Preview Section
            Row(
              children: [
                Icon(Icons.file_download, size: 30, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  "Demo IA Report.xlsx",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Upload Button
            ElevatedButton(
              onPressed: () async {
                // Use FilePicker to allow the user to pick a file
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['xls', 'xlsx'], // Restrict file types
                );

                if (result != null) {
                  // If a file is selected, you can do something with the file
                  final filePath = result.files.single.path;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('File uploaded: $filePath')),
                  );
                } else {
                  // If no file is selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No file selected')),
                  );
                }
              },
              child: const Text("Upload Your IA Report"),
            ),
            const SizedBox(height: 20),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                // Handle submit action here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Document submitted successfully!')),
                );
              },
              child: const Text("Submit Document"),
            ),
          ],
        ),
      ),
    );
  }
}
