import 'dart:io';
import 'package:flutter/material.dart';
import 'package:commonkit/commonkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'example_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHelper.init();

  await GlobalConfig().init(
    environment: AppEnvironment.development,
    baseUrls: {
      AppEnvironment.development: 'https://jsonplaceholder.typicode.com',
      AppEnvironment.production: 'https://api.production.com',
    },
    variables: {'apiKey': '12345'},
    theme: const CommonKitTheme(primaryColor: Colors.blue),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CommonKit Test',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TestHomePage(),
    );
  }
}

class TestHomePage extends StatefulWidget {
  const TestHomePage({super.key});

  @override
  State<TestHomePage> createState() => _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage> {
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _networkHelper = NetworkHelper();
  final _sessionManager = SessionManager();
  final _directoryManager = DirectoryManager();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  final _logger = Logger();
  bool _rememberMe = false;
  String _directoryStatus = '';
  String _clipboardContent = '';
  String _serializedData = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _testNetworkRequest() async {
    setState(() => _isLoading = true);
    try {
      final data = await _networkHelper.get('/posts/1');
      setState(() => _isLoading = false);
      _logger.info('Network request succeeded');
      if (!mounted) return;
      showToast(context, message: 'Network Success: ${data['title'].truncate(20)}');
    } catch (e) {
      setState(() => _isLoading = false);
      _logger.error('Network request failed', e);
      if (!mounted) return;
      showToast(context, message: 'Network Error: $e');
    }
  }

  void _testFileUpload() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _isLoading = true);
      try {
        final file = File(pickedFile.path);
        await _networkHelper.upload(
          '/upload',
          file: file,
          fields: {'title': 'Test Upload'},
        );
        setState(() => _isLoading = false);
        _logger.info('File upload succeeded');
        if (!mounted) return;
        showToast(context, message: 'File Upload Success');
      } catch (e) {
        setState(() => _isLoading = false);
        _logger.error('File upload failed', e);
        if (!mounted) return;
        showToast(context, message: 'File Upload Error: $e');
      }
    }
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final success = await _sessionManager.login(
        _emailController.text,
        _passwordController.text,
      );
      setState(() => _isLoading = false);
      _logger.info('Login attempt: ${success ? "Success" : "Failed"}');
      if (!mounted) return;
      showToast(context, message: success ? 'Login Successful' : 'Login Failed');
    }
  }

  void _logout() async {
    setState(() => _isLoading = true);
    await _sessionManager.logout();
    setState(() => _isLoading = false);
    _logger.info('User logged out');
    if (!mounted) return;
    showToast(context, message: 'Logged Out');
  }

  void _createDirectory() async {
    setState(() => _isLoading = true);
    try {
      final dir = await _directoryManager.createDirectory('test_folder');
      setState(() {
        _isLoading = false;
        _directoryStatus = 'Created: ${dir.path}';
      });
      _logger.info('Directory created: ${dir.path}');
      if (!mounted) return;
      showToast(context, message: 'Directory Created');
    } catch (e) {
      setState(() => _isLoading = false);
      _logger.error('Directory creation failed', e);
      if (!mounted) return;
      showToast(context, message: 'Error: $e');
    }
  }

  void _copyToClipboard() async {
    await ClipboardManager.copy('Sample Text');
    _logger.info('Text copied to clipboard');
    if (!mounted) return;
    showToast(context, message: 'Copied to Clipboard');
  }

  void _pasteFromClipboard() async {
    final text = await ClipboardManager.paste();
    setState(() => _clipboardContent = text ?? 'Nothing in clipboard');
    _logger.info('Pasted from clipboard: $text');
    if (!mounted) return;
    showToast(context, message: 'Pasted: $text');
  }

  void _testSerialization() {
    final data = {'name': 'John', 'age': 30};
    final jsonString = DataSerializer.serialize(data);
    final deserialized = DataSerializer.deserialize(jsonString);
    setState(() => _serializedData = 'Serialized: $jsonString\nDeserialized: $deserialized');
    _logger.info('Serialization test completed');
    showToast(context, message: 'Serialization Tested');
  }

  void _requestPermission() async {
    final granted = await PermissionManager.request(Permission.storage);
    _logger.info('Storage permission granted: $granted');
    if (!mounted) return;
    showCustomDialog(
      context,
      title: 'Permission Result',
      content: granted ? 'Storage permission granted' : 'Storage permission denied',
      positiveText: 'OK',
      negativeText: 'Settings',
      onNegative: () => PermissionManager.openSettings(),
    );
  }

  void _goToExamplePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExamplePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    return Scaffold(
      appBar: AppBar(title: Text('CommonKit Test'.capitalize())),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Username'),
                        validator: Validators.required,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: Validators.required,
                      ),
                      CheckboxListTile(
                        title: const Text('Remember Me'),
                        value: _rememberMe,
                        onChanged: (value) => setState(() => _rememberMe = value ?? false),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  text: GlobalConfig().isLoggedIn ? 'Logout' : 'Login',
                  onPressed: GlobalConfig().isLoggedIn ? _logout : _login,
                  icon: GlobalConfig().isLoggedIn ? Icons.logout : Icons.login,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Test Network',
                  onPressed: _testNetworkRequest,
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
                  text: 'Create Directory',
                  onPressed: _createDirectory,
                  icon: Icons.folder,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Copy to Clipboard',
                  onPressed: _copyToClipboard,
                  icon: Icons.copy,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Paste from Clipboard',
                  onPressed: _pasteFromClipboard,
                  icon: Icons.paste,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Test Serialization',
                  onPressed: _testSerialization,
                  icon: Icons.data_object,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Request Permission',
                  onPressed: _requestPermission,
                  icon: Icons.security,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Go to Example Page',
                  onPressed: _goToExamplePage,
                  icon: Icons.book,
                ),
                const SizedBox(height: 16),
                Text('Logged In: ${GlobalConfig().isLoggedIn}'),
                Text('Username: ${GlobalConfig().username ?? "Not set"}'),
                Text('Directory Status: $_directoryStatus'),
                Text('Clipboard: $_clipboardContent'),
                Text('Serialization: $_serializedData'),
              ],
            ),
          ),
          LoadingOverlay(isLoading: _isLoading),
        ],
      ),
    );
  }
}
