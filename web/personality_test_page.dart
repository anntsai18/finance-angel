import 'package:flutter/material.dart';
import '../../data/models/user_profile.dart';

class PersonalityTestPage extends StatefulWidget {
  final Function(UserPersona) onComplete;
  const PersonalityTestPage({super.key, required this.onComplete});

  @override
  State<PersonalityTestPage> createState() => _PersonalityTestPageState();
}

class _PersonalityTestPageState extends State<PersonalityTestPage> {
  int _index = 0;
  int _score = 0;
  static const int totalQuestions = 6;

  void _handleAnswer(int score) {
    _score += score;
    debugPrint('選項分數: $score, 目前總分: $_score, 題號: $_index');
    
    if (_index < totalQuestions - 1) {
      setState(() { _index++; });
      debugPrint('前進到下一題: $_index');
    } else {
      debugPrint('執行 _finish()');
      _finish();
    }
  }

  void _finish() {
    debugPrint('測驗完成！總分: $_score');
    UserPersona persona;
    if (_score <= 9) persona = UserPersona.conservative;
    else if (_score <= 13) persona = UserPersona.balanced;
    else persona = UserPersona.aggressive;
    debugPrint('人格類型: $persona');
    widget.onComplete(persona);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(value: (_index + 1) / totalQuestions),
              const SizedBox(height: 8),
              Text('問題 ${_index + 1}/$totalQuestions', style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              _buildQuestion(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion() {
    switch (_index) {
      case 0:
        return _buildOptions('當你突然需要一筆緊急支出（例如醫療費、修車費）時，你通常會怎麼做？', [
          ('使用存款或預備金，不影響生活', '保守型', 1),
          ('動用部分投資或調整支出', '穩健型', 2),
          ('刷信用卡或借錢度過', '積極型', 3),
        ]);
      case 1:
        return _buildOptions('你的收入中，大約會存下多少比例？', [
          ('30% 以上', '高儲蓄', 1),
          ('10% ~ 30%', '適度儲蓄', 2),
          ('10% 以下或月光族', '及時行樂', 3),
        ]);
      case 2:
        return _buildOptions('選擇投資標的時，你最在意什麼？', [
          ('本金安全，不要虧錢', '不貪心', 1),
          ('風險與收益平衡', '求穩健', 2),
          ('報酬率夠高就好', '拼一把', 3),
        ]);
      case 3:
        return _buildOptions('如果你投入的 10 萬元變成 8 萬元，你會？', [
          ('停損賣出，避免繼續虧', '保護本金', 1),
          ('先觀望，等回升', '不急着動作', 2),
          ('加碼攤平成本', '危機入市', 3),
        ]);
      case 4:
        return _buildOptions('你平時花多少時間研究投資？', [
          ('幾乎不研究', '被動理財', 1),
          ('偶爾看一下', '正常關心', 2),
          ('每天都在研究', '積極研究', 3),
        ]);
      case 5:
        return _buildOptions('當專業人士給你投資建議時，你會？', [
          ('自己查證再做決定', '相信自己', 1),
          ('參考但仍自行判斷', '參考為主', 2),
          ('直接相信嘗試', '勇於嘗試', 3),
        ]);
      default:
        return const Text('錯誤：題目不存在');
    }
  }

  Widget _buildOptions(String question, List<(String, String, int)> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        ...options.map((opt) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _handleAnswer(opt.$3),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(opt.$1, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(opt.$2, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ),
        )),
      ],
    );
  }
}
