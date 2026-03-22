import 'package:flutter/material.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('升級 Pro')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            const Text('你的財務正在流失', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            const Text('• 解鎖完整 AI 分析', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            const Text('• 每週更新建議', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            const Text('• 個人化理財策略', style: TextStyle(fontSize: 16)),
            const Spacer(),
            const Text('NT\$99/月', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF6C5CE7))),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('即將開放，敬請期待！')),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  foregroundColor: Colors.white,
                ),
                child: const Text('升級 Pro NT\$99/月', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
