import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tap_task/core/imports/common_imports.dart';

Future<void> logout(BuildContext context) async {
  try {
    await Supabase.instance.client.auth.signOut();
    // ignore: use_build_context_synchronously
    context.go('/');
  } catch (e) {
    log("❌ Error signing out: $e");
  }
}
