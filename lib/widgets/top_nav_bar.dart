import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  static const double _vPad = 12;
  static const double _logoHeight = 72;
  static const double _gapLogoToMenu = 140;
  static const double _logoShiftRight = 68; // move logo right without shifting following items
  static const double _logoScaleX = 1.30; // widen logo more than height increase
  // Reduced gap after search to pull wishlist icon left
  static const double _gapAfterSearch = 30; // was 60
  // Reduced gaps to pull cart & auth button left
  static const double _gapBetweenIcons = 12; // was 28
  static const double _gapBeforeAuth = 4; // was 12
  static const double _searchMaxWidth = 150; // decreased further per request (was 200)
  static const double _searchHeight = 36; // decreased search bar height
  // Auth button sizing
  static const double _authHeight = 40; // taller pill
  static const double _authHPad = 24; // wider horizontal padding
  static const double _authFontSize = 14; // larger readable text
  static const double _authRadius = 24; // full pill radius
  // Promo banner sizing
  static const double _promoBannerHPad = 0; // keep banner flush with screen edges
  static const double _promoBannerVPad = 0; // align banner directly under the category bar
  static const double _promoBannerAspectRatio = 1347 / 491; // width / height from provided artwork
  // Category bar sizing
  static const double _categoryHeight = 110; // increased to prevent bottom overflow for two rows
  static const double _categoryItemHeight = 28; // uniform item height
  static const double _categorySpacing = 24; // horizontal spacing between items
  static const double _categoryRunSpacing = 8; // vertical spacing between rows
  static const double _categoryHPad = 10; // horizontal padding inside item container
  static const double _categoryBorderRadius = 3; // rectangular white outline radius
  static const double _categoryTextSize = 13; // label font size
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 0,
      color: Colors.white,
      child: Scrollbar(
        thumbVisibility: true,
        interactive: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top header row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: _vPad),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: _logoShiftRight),
                      SizedBox(
                        height: _logoHeight,
                        child: Transform.scale(
                          scaleX: _logoScaleX,
                          scaleY: 1.0,
                          child: Image.asset('asset/Sri.png', fit: BoxFit.fitHeight),
                        ),
                      ),
                      SizedBox(width: _gapLogoToMenu - _logoShiftRight),
                      _NavItem(text: 'Home', fontSize: 14, padding: const EdgeInsets.only(left: 24, right: 14)),
                      _NavItem(text: 'Offers', fontSize: 14, padding: const EdgeInsets.only(left: 14, right: 24)),
                      _NavItem(text: 'Sri Rudra Stores'),
                      _NavItem(text: 'Contact Us'),
                      const SizedBox(width: 32),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: _searchMaxWidth),
                        child: SizedBox(
                          height: _searchHeight,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: _gapAfterSearch),
                      _IconBox(
                        tooltip: 'Wishlist',
                        icon: Icons.favorite_border,
                        onTap: () {},
                      ),
                      SizedBox(width: _gapBetweenIcons),
                      _IconBox(
                        tooltip: 'Cart',
                        icon: Icons.shopping_cart_outlined,
                        onTap: () {},
                      ),
                      SizedBox(width: _gapBeforeAuth),
                      SizedBox(
                        height: _authHeight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: _authHPad),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_authRadius)),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Sign Up / Sign In',
                            style: TextStyle(
                              fontSize: _authFontSize,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _CategoryMenuBar(),
              const _PromoBanner(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    final dispatcher = WidgetsBinding.instance.platformDispatcher;
    final view = dispatcher.views.isNotEmpty
        ? dispatcher.views.first
        : dispatcher.implicitView;

    final double logicalWidth;
    if (view != null) {
      logicalWidth = view.physicalSize.width / view.devicePixelRatio;
    } else {
      logicalWidth = 1280; // fall back to a sensible desktop width
    }

    final double availableBannerWidth =
        (logicalWidth - (_promoBannerHPad * 2)).clamp(0.0, double.infinity).toDouble();
    final double bannerHeight = availableBannerWidth / _promoBannerAspectRatio;
    final double totalHeight = _logoHeight +
        (_vPad * 2) +
        _categoryHeight +
        bannerHeight +
        (_promoBannerVPad * 2);
    return Size.fromHeight(totalHeight);
  }
}

class _NavItem extends StatelessWidget {
  final String text;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  const _NavItem({required this.text, this.fontSize, this.padding});

  @override
  Widget build(BuildContext context) {
    final isHovering = ValueNotifier(false);
    return MouseRegion(
      onEnter: (_) => isHovering.value = true,
      onExit: (_) => isHovering.value = false,
      cursor: SystemMouseCursors.click,
      child: ValueListenableBuilder<bool>(
        valueListenable: isHovering,
        builder: (context, hovering, child) {
          return Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 160),
              style: TextStyle(
                fontSize: fontSize ?? 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              child: Text(text),
            ),
          );
        },
      ),
    );
  }
}

class _IconBox extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  const _IconBox({required this.icon, required this.tooltip, required this.onTap});

  @override
  State<_IconBox> createState() => _IconBoxState();
}

class _IconBoxState extends State<_IconBox> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final baseBorder = Border.all(color: Colors.black, width: 1);
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.tooltip,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            // 0.05 opacity black => alpha 0x0D
            color: _hover ? const Color(0x0D000000) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: baseBorder,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              // 0.25 opacity material orange (#FF9800) => alpha 0x40
              splashColor: const Color(0x40FF9800),
              onTap: widget.onTap,
              child: Center(
                child: Icon(widget.icon, size: 16, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryMenuBar extends StatelessWidget {
  const _CategoryMenuBar();

  static const List<String> _items = [
    'Varalaxmi Vratham',
    'One Gram Gold & Silver',
    'Envelopes & Bags',
    'Peetam & Mandir',
    'Mala & Beads',
    'Books',
    'Homam & Vratham',
    'Cloth Items',
    'Fiber & Steel Items',
    'Garlands',
    'Decorative & Marriage Items',
    'Photos Frames & Yantras',
    'Sphatika & Maragaj Items',
    'German Silver',
    'Festival Needs',
    'Daily Pooja Needs',
    'Brass & Copper Items',
    'Others',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: TopNavBar._categoryHeight),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: TopNavBar._categorySpacing,
            runSpacing: TopNavBar._categoryRunSpacing,
            children: _items
                .map((label) => _CategoryButton(label: label))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _CategoryButton extends StatefulWidget {
  final String label;
  const _CategoryButton({required this.label});

  @override
  State<_CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<_CategoryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: EdgeInsets.symmetric(horizontal: TopNavBar._categoryHPad),
        height: TopNavBar._categoryItemHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TopNavBar._categoryBorderRadius),
          border: Border.all(
            color: _hover ? Colors.white : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: TopNavBar._categoryTextSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.expand_more, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  const _PromoBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TopNavBar._promoBannerHPad,
        vertical: TopNavBar._promoBannerVPad,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = width / TopNavBar._promoBannerAspectRatio;
            return SizedBox(
              width: width,
              height: height,
              child: Image.asset(
                'asset/jyo11.webp',
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: const Text(
                      'Place your banner image at asset/jyo11.webp',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}