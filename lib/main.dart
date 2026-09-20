import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'state/auth_store.dart';
import 'state/task_store.dart';
import 'storage/app_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');
  final prefs = await SharedPreferences.getInstance();
  final storage = PrefsAppStorage(prefs);
  final authStore = AuthStore(storage);
  final taskStore = TaskStore(storage);
  await authStore.load();
  await taskStore.load();
  runApp(LumenApp(authStore: authStore, taskStore: taskStore));
}
