import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jr_case_boilerplate/features/upload_photo/providers/upload_photo_provider.dart';
import 'package:jr_case_boilerplate/l10n/app_localizations.dart';

class PhotoOptionsBottomSheet extends StatelessWidget {
  final WidgetRef ref;
  const PhotoOptionsBottomSheet({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.black87),
              title: Text(AppLocalizations.of(context)!.camera),
              onTap: () async {
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                  maxWidth: 1024,
                  maxHeight: 1024,
                  imageQuality: 85,
                );
                if (image != null) {
                  ref.read(uploadPhotoProvider.notifier).photoloaded(image);
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.black87),
              title: Text(AppLocalizations.of(context)!.gallery),
              onTap: () async {
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 1024,
                  maxHeight: 1024,
                  imageQuality: 85,
                );
                if (image != null) {
                  ref.read(uploadPhotoProvider.notifier).photoloaded(image);
                  Navigator.pop(context);
                }
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
