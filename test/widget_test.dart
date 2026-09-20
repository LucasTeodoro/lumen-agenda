import 'package:flutter_test/flutter_test.dart';
import 'package:lumen_agenda/app.dart';
import 'package:lumen_agenda/state/auth_store.dart';
import 'package:lumen_agenda/state/task_store.dart';
import 'package:lumen_agenda/storage/app_storage.dart';

void main() {
  testWidgets('abre na tela de cadastro quando nao ha sessao', (tester) async {
    final storage = MemoryAppStorage();
    await tester.pumpWidget(
      LumenApp(
        authStore: AuthStore(storage),
        taskStore: TaskStore(storage),
      ),
    );

    expect(find.textContaining('LÚMEN'), findsOneWidget);
    expect(find.text('Cadastrar'), findsOneWidget);
    expect(find.text('Criar conta'), findsOneWidget);
    expect(find.text('Nome'), findsOneWidget);
  });
}
