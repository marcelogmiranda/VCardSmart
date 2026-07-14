import 'package:flutter/material.dart';
import '../../domain/entities/vcard_data.dart';

class VCardPreview extends StatelessWidget {
  final VCardData data;
  final double? width;

  const VCardPreview({
    super.key,
    required this.data,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.fullName.isNotEmpty) ...[
              Text(
                data.fullName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
            ],
            if (data.title != null && data.title!.isNotEmpty) ...[
              Text(
                data.title!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 4),
            ],
            if (data.organization != null && data.organization!.isNotEmpty) ...[
              Text(
                data.organization!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
            ],
            if (data.email != null && data.email!.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.email, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(child: Text(data.email!)),
                ],
              ),
              const SizedBox(height: 8),
            ],
            if (data.phone != null && data.phone!.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.phone, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(child: Text(data.phone!)),
                ],
              ),
              const SizedBox(height: 8),
            ],
            if (data.website != null && data.website!.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.language, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(child: Text(data.website!)),
                ],
              ),
              const SizedBox(height: 8),
            ],
            if (data.address != null && data.address!.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(child: Text(data.address!)),
                ],
              ),
            ],
            if (data.note != null && data.note!.isNotEmpty) ...[
              const Divider(height: 24),
              Text(
                data.note!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
