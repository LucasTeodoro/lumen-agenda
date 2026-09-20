import 'package:flutter_test/flutter_test.dart';
import 'package:lumen_agenda/state/auth_store.dart';
import 'package:lumen_agenda/storage/app_storage.dart';

void main() {
  late MemoryAppStorage storage;
  late AuthStore store;

  setUp(() {
    storage = MemoryAppStorage();
    store = AuthStore(storage);
  });

  test('cadastro valido autentica o usuario', () async {
    final error = await store.register(
      name: 'Lucas',
      email: 'lucas@uninube.edu',
      password: '123456',
    );

    expect(error, isNull);
    expect(store.currentUser?.name, 'Lucas');
    expect(store.currentUser?.email, 'lucas@uninube.edu');
  });

  test('cadastro rejeita email duplicado', () async {
    await store.register(
      name: 'Lucas',
      email: 'lucas@uninube.edu',
      password: '123456',
    );
    await store.logout();

    final error = await store.register(
      name: 'Outro',
      email: 'lucas@uninube.edu',
      password: 'abcdef',
    );

    expect(error, isNotNull);
    expect(store.currentUser, isNull);
  });

  test('login com senha correta recupera a sessao', () async {
    await store.register(
      name: 'Lucas',
      email: 'lucas@uninube.edu',
      password: '123456',
    );
    await store.logout();

    final error = await store.login(
      email: 'lucas@uninube.edu',
      password: '123456',
    );

    expect(error, isNull);
    expect(store.currentUser?.name, 'Lucas');
  });

  test('login falha com senha errada', () async {
    await store.register(
      name: 'Lucas',
      email: 'lucas@uninube.edu',
      password: '123456',
    );
    await store.logout();

    final error = await store.login(
      email: 'lucas@uninube.edu',
      password: 'errada',
    );

    expect(error, isNotNull);
    expect(store.currentUser, isNull);
  });

  test('login falha com email inexistente', () async {
    final error = await store.login(
      email: 'naoexiste@uninube.edu',
      password: '123456',
    );

    expect(error, isNotNull);
  });

  test('load restaura usuario da sessao persistida', () async {
    await store.register(
      name: 'Lucas',
      email: 'lucas@uninube.edu',
      password: '123456',
    );

    final reloaded = AuthStore(storage);
    await reloaded.load();

    expect(reloaded.currentUser?.email, 'lucas@uninube.edu');
  });
}
