import 'package:easy_localization/easy_localization.dart';
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
        _error = null;
      });
      await ref
          .read(authProvider.notifier)
          .login(username: username, password: password)
          .catchError((error) {
        setState(() {
          _isRequesting = false;
          _error = 'message_login_failed'.tr();
        });
      });
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
                'title_login_form'.tr(),
                style: theme.textTheme.titleLarge!
                    .copyWith(color: theme.colorScheme.onSurface),
              ),
              if (_error != null) ...[
                const SizedBox(height: 20),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: theme.colorScheme.error),
                )
              ],
              const SizedBox(height: 30),
              FormBuilderTextField(
                name: 'username',
                initialValue: '',
                autocorrect: false,
                decoration: InputDecoration(
                  label: const Text('username').tr(),
                ),
                validator: FormBuilderValidators.required(
                  errorText: 'validation_username_required'.tr(),
                ),
              ),
              const SizedBox(height: 20),
              FormBuilderTextField(
                name: 'password',
                initialValue: '',
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                  label: const Text('password').tr(),
                ),
                validator: FormBuilderValidators.required(
                  errorText: 'validation_password_required'.tr(),
                ),
              ),
              const SizedBox(height: 30),
              FilledButton(
                onPressed: _isRequesting ? null : _handleSubmit,
                style: FilledButton.styleFrom(fixedSize: const Size(200, 50)),
                child: _isRequesting
                    ? const CircularProgressIndicator()
                    : const Text('btn_login', style: TextStyle(fontSize: 20))
                        .tr(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
