import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/widgets/view_background/Stack_gradient_background.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_primary_button.dart';
import 'package:jr_case_boilerplate/features/upload_photo/widgets/photo_picker_widget.dart';
import 'package:jr_case_boilerplate/features/upload_photo/providers/upload_photo_provider.dart';
import 'package:jr_case_boilerplate/l10n/app_localizations.dart';
import 'package:jr_case_boilerplate/core/helpers/snackbar_helper.dart';

class UploadPhotoView extends ConsumerStatefulWidget {
  const UploadPhotoView({super.key});

  @override
  ConsumerState<UploadPhotoView> createState() => _UploadPhotoViewState();
}

class _UploadPhotoViewState extends ConsumerState<UploadPhotoView> {
  @override
  Widget build(BuildContext context) {
    final uploadPhotoState = ref.watch(uploadPhotoProvider);

    ref.listen(uploadPhotoProvider, (previous, next) {
      if (previous?.isLoading != next.isLoading ||
          previous?.error != next.error) {
        if (next.isLoading) {
          SnackbarHelper.success(
            context,
            AppLocalizations.of(context)!.photoUploaded,
          );
        }
      }
    });

    return Scaffold(
      body: StackGradientBackground(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeader(context),
              PhotoPickerWidget(),
              _buildBottomButtons(context, uploadPhotoState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
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
                border: Border.all(color: AppColors.baseWhite.withOpacity(0.2)),
              ),
              child: const ImageIcon(
                AssetImage('assets/images/Arrow.png'),
                color: AppColors.baseWhite,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            AppLocalizations.of(context)!.profileDetail,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.baseWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context, dynamic uploadPhotoState) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 52,
            child: CustomPrimaryButton(
              onPressed: uploadPhotoState.image == null
                  ? () {}
                  : () async {
                      await ref
                          .read(uploadPhotoProvider.notifier)
                          .uploadPhoto(uploadPhotoState.image!);
                      Navigator.of(context).pop();
                    },
              bacgroundColor: uploadPhotoState.image == null
                  ? AppColors.primary.withOpacity(0.50)
                  : AppColors.primary,
              child: Text(
                AppLocalizations.of(context)!.continueButton,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.baseWhite,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.baseWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.skip,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.baseWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
