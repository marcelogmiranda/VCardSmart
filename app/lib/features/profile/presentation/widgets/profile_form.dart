import 'package:flutter/material.dart';
import '../../domain/entities/profile.dart';

class ProfileForm extends StatefulWidget {
  final Profile? profile;
  final Function(Profile) onSubmit;

  const ProfileForm({
    super.key,
    this.profile,
    required this.onSubmit,
  });

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _linkedinController;
  late final TextEditingController _websiteController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile?.name ?? '');
    _emailController =
        TextEditingController(text: widget.profile?.email ?? '');
    _phoneController =
        TextEditingController(text: widget.profile?.phone ?? '');
    _linkedinController =
        TextEditingController(text: widget.profile?.linkedin ?? '');
    _websiteController =
        TextEditingController(text: widget.profile?.website ?? '');
    _bioController = TextEditingController(text: widget.profile?.bio ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _linkedinController.dispose();
    _websiteController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nome *',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nome é obrigatório';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Telefone',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _linkedinController,
            decoration: const InputDecoration(
              labelText: 'LinkedIn',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _websiteController,
            decoration: const InputDecoration(
              labelText: 'Website',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _bioController,
            decoration: const InputDecoration(
              labelText: 'Bio',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final profile = Profile(
        id: widget.profile?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        email: _emailController.text.isEmpty ? null : _emailController.text,
        phone: _phoneController.text.isEmpty ? null : _phoneController.text,
        linkedin:
            _linkedinController.text.isEmpty ? null : _linkedinController.text,
        website:
            _websiteController.text.isEmpty ? null : _websiteController.text,
        bio: _bioController.text.isEmpty ? null : _bioController.text,
        createdAt: widget.profile?.createdAt ?? now,
        updatedAt: now,
      );
      widget.onSubmit(profile);
    }
  }
}
