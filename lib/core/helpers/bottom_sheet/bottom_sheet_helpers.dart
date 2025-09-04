import 'package:flutter/material.dart';

/// Abstract class for bottom sheet helpers
abstract class BottomSheetHelpers {
  /// Offer a bottom sheet with the given content
  Future<void> offerBottomSheet(BuildContext context, Widget content);
}
