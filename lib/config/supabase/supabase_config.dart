import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String _supabaseUrl = 'https://wxnnfqkmfcveywhwmmli.supabase.co';
  static const String _supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind4bm5mcWttZmN2ZXl3aHdtbWxpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMwMzA0NjgsImV4cCI6MjA3ODYwNjQ2OH0.Ooqd4_tVqC4eNGT6GbtirHnIhrTy2blXT5BS8EVano8';

  static late final SupabaseClient client;

  SupabaseConfig._internal();

  static Future<void> initialize() async {
    await Supabase.initialize(url: _supabaseUrl, anonKey: _supabaseAnonKey);
    client = Supabase.instance.client;
  }
}
