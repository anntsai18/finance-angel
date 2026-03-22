import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_profile.dart';

class ProfileService {
  static const String _key = 'user_personality';

  Future<UserProfile> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_key);
    if (str == null) return const UserProfile();
    
    final persona = UserPersona.values.firstWhere(
      (e) => e.name == str,
      orElse: () => UserPersona.balanced,
    );
    return UserProfile(personality: persona);
  }

  Future<void> savePersonality(UserPersona persona) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, persona.name);
  }
}
