import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {

  final supabaseClient = Supabase.instance.client;

  //Sign In with email and password
  Future<AuthResponse> signInWithEmailPassword(String email, String password) async {
    return await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  //Sign Up with email and password
  Future<AuthResponse> signUpWithEmailPassword(String email, String password) async {
    return await supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
  }

  //Sign Out
  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }

  //Get user detail
  String? getUserDetails() {
    final session = supabaseClient.auth.currentSession;
    final user = session?.user;

    return user?.email;
  }

}