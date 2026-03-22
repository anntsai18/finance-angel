enum UserPersona {
  conservative,
  balanced,
  aggressive,
}

class UserProfile {
  final UserPersona? personality;
  const UserProfile({this.personality});

  String get title {
    if (personality == null) return '尚未測驗';
    switch (personality!) {
      case UserPersona.conservative: return '🟡 穩健守護者';
      case UserPersona.balanced: return '🔵 策略配置師';
      case UserPersona.aggressive: return '🔴 成長獵人';
    }
  }
}
