import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/image_utils.dart';
import '../../domain/entities/profile.dart';
import '../../../../../core/utils/device_contacts_service.dart';

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
  final _imagePicker = ImagePicker();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _linkedinController;
  late final TextEditingController _instagramController;
  late final TextEditingController _facebookController;
  late final TextEditingController _xController;
  late final TextEditingController _socialController;
  late final TextEditingController _websiteController;
  late final TextEditingController _bioController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<DeviceContactSuggestion> _suggestions = [];
  bool _isSearching = false;
  bool _permissionPrompted = false;
  String? _photoPath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile?.name ?? '');
    _emailController =
        TextEditingController(text: widget.profile?.email ?? '');
    _phoneController =
        TextEditingController(text: widget.profile?.phone ?? '');
    _linkedinController = TextEditingController(
      text: _linkedinHandle(widget.profile?.linkedin),
    );
    _instagramController = TextEditingController(
      text: _instagramHandle(widget.profile?.instagram),
    );
    _facebookController = TextEditingController(
      text: _facebookHandle(widget.profile?.facebook),
    );
    _xController = TextEditingController(
      text: _xHandle(widget.profile?.x),
    );
    _socialController =
        TextEditingController(text: widget.profile?.social ?? '');
    _websiteController = TextEditingController(
      text: _websiteHost(widget.profile?.website),
    );
    _bioController = TextEditingController(text: widget.profile?.bio ?? '');
    _photoPath = widget.profile?.photoPath;
    _searchFocusNode.addListener(_onSearchFieldFocus);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _linkedinController.dispose();
    _instagramController.dispose();
    _facebookController.dispose();
    _xController.dispose();
    _socialController.dispose();
    _websiteController.dispose();
    _bioController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  static const _linkedinPrefix = 'linkedin.com/in/';

  static String _linkedinHandle(String? value) {
    if (value == null || value.isEmpty) return '';
    final v = value.trim();
    final match = RegExp(r'(?:https?://)?(?:www\.)?linkedin\.com/in/(.+)')
        .firstMatch(v);
    if (match != null) return match.group(1)!;
    return v.replaceFirst(RegExp(r'^@'), '');
  }

  static String _fullLinkedin(String handle) {
    final h = handle.trim();
    if (h.isEmpty) return '';
    if (h.startsWith('http://') || h.startsWith('https://')) return h;
    if (h.startsWith('linkedin.com/in/')) return h;
    return '$_linkedinPrefix$h';
  }

  static String _instagramHandle(String? value) {
    if (value == null || value.isEmpty) return '';
    return value.trim().replaceFirst(RegExp(r'^@'), '');
  }

  static String _fullInstagram(String handle) {
    final h = handle.trim();
    if (h.isEmpty) return '';
    if (h.startsWith('@')) return h;
    return '@$h';
  }

  static const _facebookPrefix = 'facebook.com/';

  static String _facebookHandle(String? value) {
    if (value == null || value.isEmpty) return '';
    final v = value.trim();
    final match = RegExp(r'(?:https?://)?(?:www\.)?facebook\.com/(.+)')
        .firstMatch(v);
    if (match != null) return match.group(1)!;
    return v;
  }

  static String _fullFacebook(String handle) {
    final h = handle.trim();
    if (h.isEmpty) return '';
    if (h.startsWith('http://') || h.startsWith('https://')) return h;
    if (h.startsWith('facebook.com/')) return h;
    return '$_facebookPrefix$h';
  }

  static const _xPrefix = 'x.com/';

  static String _xHandle(String? value) {
    if (value == null || value.isEmpty) return '';
    final v = value.trim();
    final match =
        RegExp(r'(?:https?://)?(?:www\.)?(?:x|twitter)\.com/(.+)').firstMatch(v);
    if (match != null) return match.group(1)!;
    return v.replaceFirst(RegExp(r'^@'), '');
  }

  static String _fullX(String handle) {
    final h = handle.trim();
    if (h.isEmpty) return '';
    if (h.startsWith('http://') || h.startsWith('https://')) return h;
    if (h.startsWith('x.com/') || h.startsWith('twitter.com/')) return h;
    return '$_xPrefix$h';
  }

  static String _fullSocial(String link) {
    final l = link.trim();
    if (l.isEmpty) return '';
    if (l.startsWith('http://') || l.startsWith('https://')) return l;
    return 'https://$l';
  }

  static String _websiteHost(String? value) {
    if (value == null || value.isEmpty) return '';
    return value
        .trim()
        .replaceFirst(RegExp(r'^https?://'), '')
        .replaceFirst(RegExp(r'^www\.'), '');
  }

  static String _fullWebsite(String host) {
    final h = host.trim();
    if (h.isEmpty) return '';
    if (h.startsWith('http://') || h.startsWith('https://')) return h;
    return 'https://$h';
  }

  Future<void> _pickImage() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tirar foto'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Escolher da galeria'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            if (_photoPath != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Remover foto',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _photoPath = null);
                },
              ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final picked = await _imagePicker.pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (picked != null) {
      final saved = await ImageUtils.savePhotoLocally(
        File(picked.path),
        'photo_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      if (mounted) {
        setState(() => _photoPath = saved.path);
      }
    }
  }

  void _searchDeviceContacts(String query) async {
    if (query.length < 2) {
      setState(() {
        _suggestions = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);

    final results = await DeviceContactsService.searchContacts(query);

    if (mounted) {
      setState(() {
        _suggestions = results;
        _isSearching = false;
      });
      if (results.isEmpty && query.trim().length >= 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nenhum contato encontrado no dispositivo'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _onSearchFieldFocus() {
    if (!_searchFocusNode.hasFocus) return;
    _loadAllContacts();
  }

  Future<void> _loadAllContacts() async {
    if (_searchController.text.trim().isNotEmpty) return;

    setState(() => _isSearching = true);
    final granted = await DeviceContactsService.requestPermission();
    if (!mounted) return;
    _permissionPrompted = true;

    if (!granted) {
      setState(() {
        _suggestions = [];
        _isSearching = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Permissão de contatos negada. '
            'Habilite em Ajustes > Privacidade e Segurança > Contatos.',
          ),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    final results = await DeviceContactsService.getAllContacts();
    if (mounted) {
      setState(() {
        _suggestions = results;
        _isSearching = false;
      });
    }
  }

  void _applySuggestion(DeviceContactSuggestion suggestion) {
    _nameController.text = suggestion.name;
    if (suggestion.email != null) {
      _emailController.text = suggestion.email!;
    }
    if (suggestion.phone != null) {
      _phoneController.text = suggestion.phone!;
    }
    setState(() => _suggestions = []);
    _searchController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Dados de "${suggestion.name}" preenchidos'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Photo picker
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 56,
                backgroundColor: theme.colorScheme.primaryContainer,
                backgroundImage:
                    _photoPath != null ? FileImage(File(_photoPath!)) : null,
                child: _photoPath == null
                    ? Icon(
                        Icons.camera_alt,
                        size: 32,
                        color: theme.colorScheme.primary,
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: TextButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo_camera, size: 18),
              label: Text(_photoPath == null ? 'Adicionar foto' : 'Trocar foto'),
            ),
          ),
          const SizedBox(height: 16),

          // Device contacts card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.contact_phone,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Preencher do dispositivo',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Buscar contato no celular...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _isSearching
                          ? const Padding(
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          : IconButton(
                              icon: const Icon(Icons.contacts_outlined),
                              tooltip: 'Listar contatos',
                              onPressed: _loadAllContacts,
                            ),
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: _searchDeviceContacts,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Toque no campo para listar os contatos do celular',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  if (_suggestions.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: _suggestions.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final suggestion = _suggestions[index];
                          return ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              radius: 16,
                              child: Text(
                                suggestion.name.isNotEmpty
                                    ? suggestion.name[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            title: Text(
                              suggestion.name,
                              style: const TextStyle(fontSize: 14),
                            ),
                            subtitle: Text(
                              suggestion.email ??
                                  suggestion.phone ??
                                  '',
                              style: const TextStyle(fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () =>
                                _applySuggestion(suggestion),
                          );
                        },
                      ),
                    ),
                  ],
                  if (_isSearching == false &&
                      _suggestions.isEmpty &&
                      _searchController.text.trim().isEmpty &&
                      _permissionPrompted) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Nenhum contato encontrado no dispositivo',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Form fields
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nome *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person_outline),
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
              prefixIcon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Telefone',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _linkedinController,
            decoration: const InputDecoration(
              labelText: 'LinkedIn',
              hintText: 'seuuser',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.work_outline),
              prefixText: 'linkedin.com/in/',
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _instagramController,
            decoration: const InputDecoration(
              labelText: 'Instagram',
              hintText: 'seuuser',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.camera_alt_outlined),
              prefixText: '@',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _facebookController,
            decoration: const InputDecoration(
              labelText: 'Facebook',
              hintText: 'seupagina',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.facebook),
              prefixText: 'facebook.com/',
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _xController,
            decoration: const InputDecoration(
              labelText: 'X (Twitter)',
              hintText: 'seuuser',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.alternate_email),
              prefixText: 'x.com/',
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _socialController,
            decoration: const InputDecoration(
              labelText: 'Outra Rede Social',
              hintText: 'https://seulink.com',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.link),
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _websiteController,
            decoration: const InputDecoration(
              labelText: 'Website',
              hintText: 'seusite.com',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.language),
              prefixText: 'https://',
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _bioController,
            decoration: const InputDecoration(
              labelText: 'Bio',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.info_outline),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.save),
            label: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final profile = Profile(
        id: widget.profile?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        email:
            _emailController.text.isEmpty ? null : _emailController.text,
        phone:
            _phoneController.text.isEmpty ? null : _phoneController.text,
        linkedin: _linkedinController.text.isEmpty
            ? null
            : _fullLinkedin(_linkedinController.text),
        instagram: _instagramController.text.isEmpty
            ? null
            : _fullInstagram(_instagramController.text),
        facebook: _facebookController.text.isEmpty
            ? null
            : _fullFacebook(_facebookController.text),
        x: _xController.text.isEmpty ? null : _fullX(_xController.text),
        social: _socialController.text.isEmpty
            ? null
            : _fullSocial(_socialController.text),
        website: _websiteController.text.isEmpty
            ? null
            : _fullWebsite(_websiteController.text),
        bio:
            _bioController.text.isEmpty ? null : _bioController.text,
        photoPath: _photoPath,
        createdAt: widget.profile?.createdAt ?? now,
        updatedAt: now,
      );
      widget.onSubmit(profile);
    }
  }
}
