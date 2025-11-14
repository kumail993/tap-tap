import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tap_task/config/supabase/supabase_config.dart';

class AuthRepository {
  final SupabaseClient _client = SupabaseConfig.client;
  Future<AuthResponse> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (response.user != null) {
        log("✅ Logged in successfully: ${response.user!.email}");
      } else {
        log("⚠️ Invalid email or password");
      }

      return response;
    } on AuthException catch (e) {
      log("❌ AuthException: ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      log("❌ Unexpected error: $e");
      throw Exception("Something went wrong. Please try again.");
    }
  }
}
