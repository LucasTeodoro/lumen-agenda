import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'screens/auth_screen.dart';
import 'screens/calendar_screen.dart';
import 'state/auth_store.dart';
import 'state/task_store.dart';
import 'theme/lumen_theme.dart';

class LumenApp extends StatelessWidget {
  const LumenApp({
    super.key,
    required this.authStore,
    required this.taskStore,
  });

  final AuthStore authStore;
  final TaskStore taskStore;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authStore),
        ChangeNotifierProvider.value(value: taskStore),
      ],
      child: MaterialApp(
        title: 'Lúmen Agenda',
        debugShowCheckedModeBanner: false,
        theme: LumenTheme.dark(),
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [Locale('pt', 'BR')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Consumer<AuthStore>(
          builder: (context, auth, _) {
            if (auth.currentUser == null) {
              return const AuthScreen();
            }
            return const CalendarScreen();
          },
        ),
      ),
    );
  }
}
