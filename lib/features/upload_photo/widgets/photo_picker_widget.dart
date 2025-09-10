import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:jr_case_boilerplate/features/upload_photo/providers/upload_photo_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jr_case_boilerplate/l10n/app_localizations.dart';
import 'photo_options_bottomsheet.dart';

class PhotoPickerWidget extends ConsumerWidget {
  const PhotoPickerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadPhotoState = ref.watch(uploadPhotoProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            color: AppColors.black.withOpacity(0.25),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/images/Profile-fill.svg',
              width: 32,
              height: 40,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          AppLocalizations.of(context)!.uploadPhoto,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(color: AppColors.baseWhite),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.uploadSubtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.baseWhite.withOpacity(0.9),
          ),
        ),
        const SizedBox(height: 48),
        uploadPhotoState.image == null
            ? GestureDetector(
                onTap: () => _showPhotoOptions(context, ref),
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
                      child: ImageIcon(
                        AssetImage('assets/images/Plus.png'),
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
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(32),
                      child: Image.file(
                        File(uploadPhotoState.image!.path),

                        width: 176,
                        height: 176,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      ref.read(uploadPhotoProvider.notifier).clearPhoto();
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(900),
                        boxShadow: const [BoxShadow(blurRadius: 20)],
                        border: Border.all(
                          color: AppColors.baseWhite.withOpacity(0.5),
                        ),
                        color: AppColors.black.withOpacity(0.5),
                      ),
                      child: const ImageIcon(
                        AssetImage('assets/images/X.png'),
                        size: 24,
                        color: AppColors.baseWhite,
                      ),
                    ),
                  ),
                ],
              ),
        const SizedBox(height: 60),
      ],
    );
  }

  void _showPhotoOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return PhotoOptionsBottomSheet(ref: ref);
      },
    );
  }
}
