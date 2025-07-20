import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

/// Écran de création de dossier
class CreateDossierScreen extends StatefulWidget {
  const CreateDossierScreen({super.key});

  @override
  State<CreateDossierScreen> createState() => _CreateDossierScreenState();
}

class _CreateDossierScreenState extends State<CreateDossierScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numeroController = TextEditingController();
  final _clientController = TextEditingController();
  final _adresseController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _numeroController.dispose();
    _clientController.dispose();
    _adresseController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textPrimary,
        title: const Text(
          'Nouveau Dossier',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _saveDossier,
            child: const Text(
              'Sauvegarder',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFormField(
                controller: _numeroController,
                label: 'Numéro du dossier',
                hint: 'Ex: DOS-2024-001',
                icon: Icons.numbers,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le numéro du dossier est requis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildFormField(
                controller: _clientController,
                label: 'Client',
                hint: 'Nom du client',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le nom du client est requis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildFormField(
                controller: _adresseController,
                label: 'Adresse',
                hint: 'Adresse du projet',
                icon: Icons.location_on,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'L\'adresse est requise';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildFormField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Description du dossier',
                icon: Icons.description,
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              _buildCreateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: AppColors.surface,
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return ElevatedButton(
      onPressed: _saveDossier,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textPrimary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Créer le dossier',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  void _saveDossier() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implémenter la création du dossier
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dossier créé avec succès'),
          backgroundColor: AppColors.success,
        ),
      );
      context.pop();
    }
  }
}
