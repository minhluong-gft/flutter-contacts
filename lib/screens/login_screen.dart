import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/auth_provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isRequesting = false;
  String? _error;

  void _handleSubmit() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final values = _formKey.currentState!.value;
      final username = values['username'];
      final password = values['password'];
      setState(() {
        _isRequesting = true;
      });
      await ref
          .read(authProvider.notifier)
          .login(username: username, password: password);

      // setState(() {
      //   _isRequesting = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(50),
          alignment: Alignment.center,
          color: theme.colorScheme.surface,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Login to continue",
                style: theme.textTheme.titleLarge!
                    .copyWith(color: theme.colorScheme.onSurface),
              ),
              const SizedBox(height: 30),
              FormBuilderTextField(
                name: 'username',
                initialValue: 'user',
                autocorrect: false,
                decoration: const InputDecoration(
                  label: Text('Username'),
                ),
                validator: FormBuilderValidators.required(
                  errorText: 'Please enter username',
                ),
              ),
              const SizedBox(height: 20),
              FormBuilderTextField(
                name: 'password',
                initialValue: '123',
                obscureText: true,
                autocorrect: false,
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
                validator: FormBuilderValidators.required(
                  errorText: 'Please enter password',
                ),
              ),
              const SizedBox(height: 30),
              FilledButton(
                onPressed: _isRequesting ? null : _handleSubmit,
                style: FilledButton.styleFrom(fixedSize: const Size(200, 50)),
                child: _isRequesting
                    ? const CircularProgressIndicator()
                    : const Text('Login', style: TextStyle(fontSize: 20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
