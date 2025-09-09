import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import 'package:jr_case_boilerplate/core/widgets/buttons/custom_primary_button.dart';
import 'package:jr_case_boilerplate/core/widgets/view_background/Stack_gradient_background.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int selectedPackageIndex = 1; // Default olarak ortadaki paket seçili

  @override
  Widget build(BuildContext context) {
    return StackGradientBackground(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Kapatma butonu ve başlık
              _buildHeader(),
              const SizedBox(height: 12),

              // Alt başlık
              _buildSubtitle(),
              const SizedBox(height: 24),

              // Bonus özellikler
              _buildBonusFeatures(),
              const SizedBox(height: 32),

              // Paket seçim başlığı
              _buildPackageSelectionTitle(),
              const SizedBox(height: 32),

              // Paket seçenekleri
              _buildPackageOptions(),
              const SizedBox(height: 24),

              // Devam et butonu
              _buildContinueButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 24), // Başlığı ortalamak için
        Text(
          'Sınırlı Teklif',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(color: AppColors.baseWhite),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(900),
              border: Border.all(color: AppColors.baseWhite.withOpacity(0.5)),
              boxShadow: const [BoxShadow(blurRadius: 20)],
            ),
            child: const Icon(
              Icons.close,
              color: AppColors.baseWhite,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Jeton paketini şimdi satın alırsın kazanım ve yeni\nbağlantıları bildirim açık!',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: AppColors.baseWhite.withOpacity(0.9),
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildBonusFeatures() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: RadialGradient(
          colors: [
            AppColors.baseWhite.withOpacity(0.1),
            AppColors.baseWhite.withOpacity(0.03),
          ],
        ),
        border: Border.all(color: AppColors.baseWhite.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            'Alacağınız Bonuslar',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.baseWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBonusItem(Icons.star, 'Premium\nMesaj'),
              _buildBonusItem(Icons.favorite, 'Daha\nFazla Eşleşme'),
              _buildBonusItem(Icons.visibility, 'Öne\nÇıkarma'),
              _buildBonusItem(Icons.favorite_border, 'Daha\nFazla Beğeni'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBonusItem(IconData icon, String text) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(11),
          width: 56,
          height: 56,

          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.bottomSheetButton2,

            boxShadow: [
              BoxShadow(
                blurRadius: 8.33,
                color: AppColors.baseWhite,
                blurStyle: BlurStyle.solid,
              ),
            ],
          ),

          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildPackageSelectionTitle() {
    return Text(
      'Kişili açmak için bir jeton paketi seçin',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w500,
        color: AppColors.baseWhite,
      ),
    );
  }

  Widget _buildPackageOptions() {
    final packages = [
      PackageOption(
        tokens: "200",
        bonus: "300",
        price: '₺99,99',
        discount: '+50%',
        isPopular: false,
      ),
      PackageOption(
        tokens: "2.000",
        bonus: "3.375",
        price: '₺799,99',
        discount: '+70%',
        isPopular: true,
      ),
      PackageOption(
        tokens: "1.000",
        bonus: "1.350",
        price: '₺399,99',
        discount: '+35%',
        isPopular: false,
      ),
    ];

    return Row(
      children: packages.asMap().entries.map((entry) {
        int index = entry.key;
        PackageOption package = entry.value;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: index == 1 ? 4 : 8),
            child: _buildPackageCard(package, index == selectedPackageIndex),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPackageCard(PackageOption package, bool isSelected) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentGeometry.center,
      children: [
        // Ana container
        Container(
          width: 110,
          height: 186,
          decoration: BoxDecoration(
            gradient: package.isPopular
                ? const RadialGradient(
                    colors: [
                      AppColors.bottomSheetCardGradient,
                      AppColors.navBarItemgraientColor,
                    ],
                    stops: [0.1, 1],
                    radius: 1.7,
                    center: AlignmentGeometry.topLeft,
                  )
                : const RadialGradient(
                    colors: [
                      AppColors.bottomSheetButton2,
                      AppColors.navBarItemgraientColor,
                    ],
                    stops: [0.2, 1],
                    radius: 1.7,
                    center: AlignmentGeometry.topLeft,
                  ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.baseWhite.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(
                color: AppColors.baseWhite.withOpacity(0.3),
                offset: const Offset(-4, -4),
                blurRadius: 15,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Token miktarı
                Text(
                  package.tokens.toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.baseWhite.withOpacity(0.90),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Bonus miktarı
                Text(
                  package.bonus.toString(),
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: AppColors.baseWhite,
                  ),
                ),

                // Jeton yazısı
                Text(
                  'Jeton',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.baseWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),

                // Fiyat
                Text(
                  package.price,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.baseWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Başına düşen fiyat
                Text(
                  'Başına haftalık',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.baseWhite.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: -10,

          child: Container(
            height: 23,
            width: 61,

            decoration: BoxDecoration(
              color: package.isPopular
                  ? AppColors.bottomSheetCardGradient
                  : AppColors.bottomSheetButton2,
              borderRadius: const BorderRadius.all(Radius.circular(24)),

              boxShadow: const [
                BoxShadow(blurRadius: 8.33, color: AppColors.baseWhite),
              ],
            ),
            child: Center(
              child: Text(
                package.discount,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.baseWhite,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: CustomPrimaryButton(
        onPressed: () {
          // Devam et işlemi
          Navigator.pop(context);
        },

        child: Text(
          'Tüm Jetonları Gör',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.baseWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class PackageOption {
  final String tokens;
  final String bonus;
  final String price;
  final String discount;
  final bool isPopular;

  PackageOption({
    required this.tokens,
    required this.bonus,
    required this.price,
    required this.discount,
    required this.isPopular,
  });
}

// Bottom sheet'i göstermek için kullanılacak fonksiyon
void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: const CustomBottomSheet(),
    ),
  );
}
