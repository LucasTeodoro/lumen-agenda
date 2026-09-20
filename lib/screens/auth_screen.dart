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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  children: [
                    const Text(
                      'Lúmen',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.6,
                        color: LumenColors.text,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Entre para ver o calendário e as tarefas do dia.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: LumenColors.muted, fontSize: 14),
                    ),
                    const SizedBox(height: 24),
                    GlassCard(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            if (_registerMode) ...[
                              const _FieldLabel('Nome'),
                              TextFormField(
                                controller: _name,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  hintText: 'Seu nome',
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().length < 2) {
                                    return 'Informe seu nome.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),
                            ],
                            const _FieldLabel('E-mail'),
                            TextFormField(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: 'voce@email.com',
                              ),
                              validator: (value) {
                                final email = value?.trim() ?? '';
                                if (!email.contains('@') || !email.contains('.')) {
                                  return 'E-mail inválido.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),
                            const _FieldLabel('Senha'),
                            TextFormField(
                              controller: _password,
                              obscureText: true,
                              onFieldSubmitted: (_) => _submit(),
                              decoration: const InputDecoration(
                                hintText: 'Mínimo 6 caracteres',
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
                                style: const TextStyle(
                                  color: LumenColors.destructive,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                            const SizedBox(height: 20),
                            if (_busy)
                              const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              )
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: LumenColors.text,
          fontSize: 14,
          fontWeight: FontWeight.w500,
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
        color: LumenColors.accent,
        borderRadius: BorderRadius.circular(LumenTheme.radius),
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
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: active ? LumenColors.background : Colors.transparent,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: active ? LumenColors.text : LumenColors.muted,
            ),
          ),
        ),
      ),
    );
  }
}
