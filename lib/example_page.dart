import 'dart:io';
import 'package:flutter/material.dart';
import 'package:commonkit/commonkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final _networkHelper = NetworkHelper();
  final _directoryManager = DirectoryManager();
  final _sessionManager = SessionManager();
  String _status = '';

  Future<void> _testNetwork() async {
    try {
      setState(() => _status = 'Fetching...');
      final data = await _networkHelper.get('/posts/1');
      setState(() => _status = 'Network: ${data['title'].truncate(20)}');
      showToast(context, message: 'Network Success');
    } catch (e) {
      setState(() => _status = 'Network Error: $e');
      showCustomDialog(context, title: 'Error', content: e.toString());
    }
  }

  Future<void> _testFileUpload() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _status = 'Uploading...');
      final file = File(pickedFile.path);
      try {
        final data = await _networkHelper.post(
          '/upload',
          body: {'title': 'Example Upload'},
          files: [file],
        );
        setState(() => _status = 'Upload: $data');
        showToast(context, message: 'Upload Success');
      } catch (e) {
        setState(() => _status = 'Upload Error: $e');
      }
    }
  }

  Future<void> _testDirectory() async {
    setState(() => _status = 'Creating directory...');
    final dir = await _directoryManager.createDirectory('example_dir');
    await _directoryManager.createFile('example_dir/test.txt', content: 'Example');
    setState(() => _status = 'Directory: ${dir.path}');
    showToast(context, message: 'Directory Created');
  }

  Future<void> _testClipboard() async {
    await ClipboardManager.copy('Example Text');
    final pasted = await ClipboardManager.paste();
    setState(() => _status = 'Clipboard: $pasted');
    showToast(context, message: 'Copied and Pasted');
  }

  Future<void> _testPermission() async {
    final granted = await PermissionManager.request(Permission.storage);
    setState(() => _status = 'Permission: ${granted ? "Granted" : "Denied"}');
    showCustomDialog(
      context,
      title: 'Permission',
      content: granted ? 'Storage granted' : 'Storage denied',
      negativeText: granted ? null : 'Settings',
      onNegative: granted ? null : () => PermissionManager.openSettings(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CommonKit Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Try out CommonKit features:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Test Network Request',
              onPressed: _testNetwork,
              icon: Icons.network_check,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Test File Upload',
              onPressed: _testFileUpload,
              icon: Icons.upload_file,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Test Directory Management',
              onPressed: _testDirectory,
              icon: Icons.folder,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Test Clipboard',
              onPressed: _testClipboard,
              icon: Icons.copy,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Test Permission',
              onPressed: _testPermission,
              icon: Icons.security,
            ),
            const SizedBox(height: 16),
            Text('Status: $_status', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}