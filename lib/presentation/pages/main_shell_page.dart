import 'package:flutter/material.dart';
import '../../data/models/user_profile.dart';
import 'dashboard_page.dart';
import 'personality_test_page.dart';

class MainShellPage extends StatefulWidget {
  final UserPersona personality;
  final VoidCallback onResetTest;
  
  const MainShellPage({
    super.key, 
    required this.personality,
    required this.onResetTest,
  });

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardPage(
            personality: widget.personality,
            onResetTest: widget.onResetTest,
          ),
          const Center(child: Text('記帳功能')),
          const Center(child: Text('投資功能')),
          const Center(child: Text('帳戶功能')),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: '首頁'),
          NavigationDestination(icon: Icon(Icons.receipt), label: '記帳'),
          NavigationDestination(icon: Icon(Icons.trending_up), label: '投資'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet), label: '帳戶'),
        ],
      ),
    );
  }
}
