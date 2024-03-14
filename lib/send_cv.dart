import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class SendCVScreen extends StatefulWidget {
  const SendCVScreen({super.key});

  @override
  State<SendCVScreen> createState() => _SendCVScreenState();
}

class _SendCVScreenState extends State<SendCVScreen> {
  PlatformFile? file;

  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CodeX Labs - Colombo, Sri Lanka',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 24.0),
            const Text("CV"),
            GestureDetector(
              onTap: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );
                if (result == null) return;

                file = result.files.first;
              },
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(6),
                child: const SizedBox(
                  width: 400,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.drive_folder_upload_outlined),
                      Text("Upload your CV")
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            const Text('Message'),
            const SizedBox(height: 8.0),
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(0.0), // Remove border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), // Adjust shadow color
                    offset:
                        const Offset(0.0, 3.0), // Adjust shadow offset (X, Y)
                    blurRadius: 3.0, // Adjust shadow blur radius
                  ),
                ],
              ),
              child: TextFormField(
                onChanged: (value) {},
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Lorem Ipsum is...',
                  contentPadding: EdgeInsets.all(15),
                ),
              ),
            ),
            const Spacer(),
            // ElevatedButton(
            //   onPressed: () {
            //     // Handle submit
            //   },
            //   child: const Text('Submit'),
            // ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(
          bottom: 30,
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);
          },
          label: const Text('Apply Filters'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
