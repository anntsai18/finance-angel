import 'dart:html' as html;
import 'package:flutter/material.dart';
import '../../data/models/user_profile.dart';
import 'paywall_page.dart';

class DashboardPage extends StatefulWidget {
  final UserPersona personality;
  final VoidCallback onResetTest;
  
  const DashboardPage({
    super.key, 
    required this.personality,
    required this.onResetTest,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isPremium = false;

  List<String> _getSuggestions() {
    switch (widget.personality) {
      case UserPersona.conservative:
        return ['減少餐飲支出', '建立緊急預備金', '投資 ETF'];
      case UserPersona.balanced:
        return ['資產配置 60/40', '每月檢視投資', '控制娛樂支出'];
      case UserPersona.aggressive:
        return ['增加成長股', '設定停損', '控制交易頻率'];
    }
  }

  String _getEmoji() {
    switch (widget.personality) {
      case UserPersona.conservative: return '🛡️';
      case UserPersona.balanced: return '⚖️';
      case UserPersona.aggressive: return '🚀';
    }
  }

  void _handleReset() {
    debugPrint('重新測驗按鈕被點擊！');
    // 清除 localStorage
    html.window.localStorage.remove('user_personality');
    // 重新載入頁面
    html.window.location.reload();
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = _getSuggestions();
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('總資產', style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 8),
            const Text('NT\$ 0', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(_getEmoji(), style: const TextStyle(fontSize: 32)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.personality.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          const Text('理財風格', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _handleReset,
                      icon: const Icon(Icons.refresh),
                      label: const Text('重新測驗'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text('🤖', style: TextStyle(fontSize: 20)),
                              SizedBox(width: 8),
                              Text('AI 財務分析', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text('系統根據你的記帳與人格給出建議', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(height: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: suggestions
                                  .take(_isPremium ? 3 : 1)
                                  .map((s) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text('• $s', style: const TextStyle(fontSize: 14)),
                                  )).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  if (!_isPremium && suggestions.length > 1)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('解鎖剩餘 2 條 AI 建議'),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallPage())),
                              child: const Text('升級 Pro'),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
