import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/app_theme.dart';
import 'data/models/user_profile.dart';
import 'presentation/pages/main_shell_page.dart';
import 'presentation/pages/personality_test_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FinanceAngelApp());
}

class FinanceAngelApp extends StatelessWidget {
  const FinanceAngelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '理財天使',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const AppLauncher(),
    );
  }
}

class AppLauncher extends StatefulWidget {
  const AppLauncher({super.key});

  @override
  State<AppLauncher> createState() => _AppLauncherState();
}

class _AppLauncherState extends State<AppLauncher> {
  bool _isLoading = true;
  UserPersona? _personality;
  bool _showTest = false; // 新增狀態

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString('user_personality');
    
    if (str != null) {
      _personality = UserPersona.values.firstWhere(
        (e) => e.name == str,
        orElse: () => UserPersona.balanced,
      );
    }
    
    setState(() => _isLoading = false);
  }

  void _onTestComplete(UserPersona persona) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_personality', persona.name);
    
    if (mounted) {
      setState(() {
        _personality = persona;
        _showTest = false;
      });
    }
  }

  void _onResetTest() {
    setState(() {
      _showTest = true;
      _personality = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // 狀態驅動：顯示測驗或 Dashboard
    if (_showTest || _personality == null) {
      return PersonalityTestPage(onComplete: _onTestComplete);
    }

    return MainShellPage(
      personality: _personality!,
      onResetTest: _onResetTest,
    );
  }
}
