import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/auth_store.dart';
import '../theme/lumen_theme.dart';
import '../widgets/aurora_backdrop.dart';
import '../widgets/glass_card.dart';
import '../widgets/lumen_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _registerMode = true;
  bool _busy = false;
  String? _formError;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _formError = null);
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _busy = true);
    final auth = context.read<AuthStore>();
    final error = _registerMode
        ? await auth.register(
            name: _name.text,
            email: _email.text,
            password: _password.text,
          )
        : await auth.login(
            email: _email.text,
            password: _password.text,
          );
    if (!mounted) {
      return;
    }
    setState(() {
      _busy = false;
      _formError = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuroraBackdrop(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  children: [
                    const Text(
                      '✦ LÚMEN',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                        color: LumenColors.text,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'agenda de luz — tarefas que brilham no dia certo',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: LumenColors.muted),
                    ),
                    const SizedBox(height: 28),
                    GlassCard(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _ModeToggle(
                              registerMode: _registerMode,
                              onChanged: (value) {
                                setState(() {
                                  _registerMode = value;
                                  _formError = null;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            if (_registerMode)
                              TextFormField(
                                controller: _name,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  labelText: 'Nome',
                                  prefixIcon: Icon(Icons.person_outline),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().length < 2) {
                                    return 'Informe seu nome.';
                                  }
                                  return null;
                                },
                              ),
                            if (_registerMode) const SizedBox(height: 12),
                            TextFormField(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: 'E-mail',
                                prefixIcon: Icon(Icons.alternate_email),
                              ),
                              validator: (value) {
                                final email = value?.trim() ?? '';
                                if (!email.contains('@') || !email.contains('.')) {
                                  return 'E-mail inválido.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _password,
                              obscureText: true,
                              onFieldSubmitted: (_) => _submit(),
                              decoration: const InputDecoration(
                                labelText: 'Senha',
                                prefixIcon: Icon(Icons.lock_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.length < 6) {
                                  return 'Mínimo de 6 caracteres.';
                                }
                                return null;
                              },
                            ),
                            if (_formError != null) ...[
                              const SizedBox(height: 12),
                              Text(
                                _formError!,
                                style: const TextStyle(color: LumenColors.pink),
                              ),
                            ],
                            const SizedBox(height: 20),
                            if (_busy)
                              const CircularProgressIndicator()
                            else
                              LumenButton(
                                label: _registerMode ? 'Criar conta' : 'Entrar',
                                onPressed: _submit,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModeToggle extends StatelessWidget {
  const _ModeToggle({
    required this.registerMode,
    required this.onChanged,
  });

  final bool registerMode;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0x22000000),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _chip('Cadastrar', registerMode, () => onChanged(true)),
          _chip('Entrar', !registerMode, () => onChanged(false)),
        ],
      ),
    );
  }

  Widget _chip(String label, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: active
                ? const LinearGradient(
                    colors: [LumenColors.teal, LumenColors.violet],
                  )
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: active ? const Color(0xFF07101C) : LumenColors.muted,
            ),
          ),
        ),
      ),
    );
  }
}
