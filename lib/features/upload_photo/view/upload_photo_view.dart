import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_primary_button.dart';
import 'package:jr_case_boilerplate/core/widgets/view_background/Stack_gradient_background.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/features/upload_photo/providers/upload_photo_provider.dart';

class UploadPhotoView extends ConsumerStatefulWidget {
  const UploadPhotoView({super.key});

  @override
  ConsumerState<UploadPhotoView> createState() => _UploadPhotoViewState();
}

class _UploadPhotoViewState extends ConsumerState<UploadPhotoView> {
  @override
  Widget build(BuildContext context) {
    final uploadPhotoState = ref.watch(uploadPhotoProvider);
    if (ref.read(uploadPhotoProvider).isLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fotoğraf Yüklendi'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }

    return Scaffold(
      body: StackGradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 44,
                        height: 44,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.baseWhite.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.baseWhite.withOpacity(0.2),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.baseWhite,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Profil Detayı',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.baseWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Main content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile icon
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.baseWhite.withOpacity(0.7),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Title
                    Text(
                      'Fotoğraf Yükle',
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(color: AppColors.baseWhite),
                    ),

                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      'Profil fotoğrafın için görsel\nyükleyebilirsin',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.baseWhite.withOpacity(0.9),
                      ),
                    ),

                    const SizedBox(height: 48),
                    uploadPhotoState.image == null
                        ? GestureDetector(
                            onTap: () {
                              _showPhotoOptions(context);
                            },
                            child: DottedBorder(
                              color: AppColors.baseWhite.withOpacity(0.2),
                              dashPattern: const [4, 4],
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(32),
                              child: Container(
                                width: 176,
                                height: 176,
                                decoration: BoxDecoration(
                                  color: AppColors.baseWhite.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: const SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: Icon(
                                    Icons.add,
                                    size: 22,
                                    color: AppColors.baseWhite,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                width: 176,
                                height: 176,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.file(
                                      File(uploadPhotoState.image!.path),
                                      width: 176,
                                      height: 176,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(uploadPhotoProvider.notifier)
                                      .clearPhoto();
                                },
                                child: Container(
                                  width: 36,
                                  height: 36,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(900),
                                    boxShadow: const [
                                      BoxShadow(blurRadius: 20),
                                    ],
                                    border: Border.all(
                                      color: AppColors.baseWhite.withOpacity(
                                        0.5,
                                      ),
                                    ),
                                    color: AppColors.black.withOpacity(0.5),
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 24,
                                    color: AppColors.baseWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),

                    const SizedBox(height: 60),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: CustomPrimaryButton(
                        onPressed: uploadPhotoState.image == null
                            ? () {}
                            : () {
                                ref
                                    .read(uploadPhotoProvider.notifier)
                                    .uploadPhoto(uploadPhotoState.image!);
                              },
                        bacgroundColor: uploadPhotoState.image == null
                            ? AppColors.primary.withOpacity(0.50)
                            : AppColors.primary,
                        child: Text(
                          "Devam Et",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.baseWhite,
                              ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Skip button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: TextButton(
                        onPressed: () {
                          _handleSkip();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.baseWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Atla',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: AppColors.baseWhite,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPhotoOptions(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
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
                  title: const Text('Kamera'),
                  onTap: () async {
                    // Navigator.pop(context);

                    final XFile? image = await picker.pickImage(
                      source: ImageSource.camera,
                      maxWidth: 1024,
                      maxHeight: 1024,
                      imageQuality: 85,
                    );

                    if (image != null) {
                      ref.read(uploadPhotoProvider.notifier).photoloaded(image);
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: Colors.black87,
                  ),
                  title: const Text('Galeri'),
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
      },
    );
  }

  void _handleContinue() {
    // Navigate to next screen or handle continue action
  }

  void _handleSkip() {
    // Navigate to next screen or handle skip action
  }
}
