import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_contacts/models/contact.dart';

class NewContactForm extends StatefulWidget {
  const NewContactForm({super.key});

  @override
  State<NewContactForm> createState() => _NewContactFormState();
}

class _NewContactFormState extends State<NewContactForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _handleSubmit() {
    if (_formKey.currentState!.saveAndValidate()) {
      final formValues = _formKey.currentState!.value;
      final newContract = Contact(
          id: DateTime.now().toString(),
          avatar: null,
          fullName: formValues['fullName'] as String,
          email: formValues['email'] as String,
          isFavorite: false);

      Navigator.of(context).pop(newContract);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTextColor = theme.colorScheme.onSurface;

    return FormBuilder(
      key: _formKey,
      child: SizedBox(
        height: 500,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Theme(
            data: theme.copyWith(
                textTheme: theme.textTheme.copyWith(
              bodyLarge: TextStyle(color: inputTextColor),
            )),
            child: Column(
              children: [
                Text(
                  "Add Contact",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 40),
                FormBuilderTextField(
                  name: 'fullName',
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Full Name')),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.maxLength(50),
                  ]),
                ),
                const SizedBox(height: 20),
                FormBuilderTextField(
                  name: 'email',
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(label: Text('Email')),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                const Spacer(flex: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 16),
                    FilledButton(
                      onPressed: _handleSubmit,
                      child: const Text('Add Contact'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
