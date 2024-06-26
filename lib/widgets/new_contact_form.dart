import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/providers/contacts_provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class NewContactForm extends ConsumerStatefulWidget {
  const NewContactForm({super.key});

  @override
  ConsumerState<NewContactForm> createState() => _NewContactFormState();
}

class _NewContactFormState extends ConsumerState<NewContactForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isSubmiting = false;
  String? createContactError;

  void _handleSubmit() async {
    if (!_formKey.currentState!.saveAndValidate()) {
      return;
    }
    final formValues = _formKey.currentState!.value;
    final addContact = ref.read(contactsProvider.notifier).addContact;
    setState(() {
      isSubmiting = true;
    });
    addContact(
      fullName: formValues['fullName'],
      email: formValues['email'],
      avatar: formValues['avatar'],
    ).then(
      (value) {
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('message_add_contact_success').tr()));
          Navigator.of(context).pop();
        }
      },
    ).catchError((error) {
      setState(() {
        createContactError = error.toString();
        isSubmiting = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: SizedBox(
        height: 500,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            children: [
              Text(
                'title_add_contact'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 40),
              FormBuilderTextField(
                name: 'fullName',
                maxLength: 50,
                decoration: InputDecoration(label: const Text('fullName').tr()),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.maxLength(50),
                ]),
              ),
              const SizedBox(height: 20),
              FormBuilderTextField(
                name: 'email',
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(label: const Text('email').tr()),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              if (createContactError != null) Text(createContactError!),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed:
                        isSubmiting ? null : () => Navigator.of(context).pop(),
                    child: const Text('cancel').tr(),
                  ),
                  const SizedBox(width: 16),
                  FilledButton(
                    onPressed: isSubmiting ? null : _handleSubmit,
                    child: isSubmiting
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator())
                        : const Text('btn_add_contact').tr(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
