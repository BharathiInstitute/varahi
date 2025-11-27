import 'dart:async';

import 'package:flutter/material.dart';
import 'featured_products_section.dart';

const List<String> _promoBannerImages = [
  'asset/jyo11.webp',
  'asset/varahi2.png',
  'asset/varahi3.png',
  'asset/varahi4.png',
  'asset/varahi5.png',
  'asset/varahi6.png',
  'asset/varahi7.png',
  'asset/varahi8.png',
];

const Duration _promoBannerAutoAdvanceDelay = Duration(seconds: 15);

class TopNavBar extends StatefulWidget implements PreferredSizeWidget {
  static const double _topSectionPadTop = 12;
  static const double _topSectionPadBottom = 0;
  static const double _outerHPad = 56;
  static const double _logoHeight = 110;
  static const double _logoWidth = 220;
  static const double _gapLogoToMenu = 100;
  static const double _logoShiftRight = 16;
  static const double _gapAfterSearch = 30;
  static const double _gapBetweenIcons = 12;
  static const double _gapBeforeAuth = 4;
  static const double _searchMaxWidth = 150;
  static const double _searchHeight = 36;
  static const double _authHeight = 40;
  static const double _authHPad = 24;
  static const double _authFontSize = 14;
  static const double _authRadius = 24;
  static const double _promoBannerHPad = 0;
  static const double _promoBannerVPad = 0;
  static const double _promoBannerAspectRatio = 1347 / 491;
  static const double _categoryHeight = 140;
  static const double _categoryItemHeight = 34;
  static const double _categorySpacing = 18;
  static const double _categoryRunSpacing = 6;
  static const double _categoryHPad = 12;
  static const double _categoryVPad = 14;
  static const double _categoryBorderRadius = 3;
  static const double _categoryTextSize = 15;
  static const double _categorySelectorSectionHeight = 300;
  static const double _featuredProductsSectionHeight = 380;
  static const double _brassCopperSectionHeight = 380;
  static const double _dailyPoojaSectionHeight = 380;
  static const double _festivalNeedsSectionHeight = 380;
  static const double _categoryHighlightsSectionHeight = 240;

  const TopNavBar({super.key});

  @override
  State<TopNavBar> createState() => _TopNavBarState();

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
      logicalWidth = 1280;
    }

    final double availableBannerWidth = (logicalWidth - (_promoBannerHPad * 2))
        .clamp(0.0, double.infinity)
        .toDouble();
    final double bannerHeight = availableBannerWidth / _promoBannerAspectRatio;
    final double totalHeight =
        _logoHeight +
        _topSectionPadTop +
        _topSectionPadBottom +
        _categoryHeight +
        bannerHeight +
        (_promoBannerVPad * 2) +
        _categorySelectorSectionHeight +
        _featuredProductsSectionHeight +
        _brassCopperSectionHeight +
        _dailyPoojaSectionHeight +
        _festivalNeedsSectionHeight +
        _categoryHighlightsSectionHeight;
    return Size.fromHeight(totalHeight);
  }
}

class _TopNavBarState extends State<TopNavBar> {
  int? _activeDropdownIndex;
  bool _dropdownHovering = false;
  Timer? _dropdownCloseTimer;
  Timer? _bannerAutoTimer;
  int _activeBannerIndex = 0;

  List<String> get _activeDropdownItems {
    final index = _activeDropdownIndex;
    if (index == null || index < 0 || index >= _categoryDefinitions.length) {
      return const [];
    }
    return _categoryDefinitions[index].dropdownItems;
  }

  @override
  void initState() {
    super.initState();
    _scheduleBannerAutoAdvance();
  }

  void _onCategoryEnter(int index) {
    _dropdownCloseTimer?.cancel();
    final hasDropdown = _categoryDefinitions[index].dropdownItems.isNotEmpty;
    setState(() {
      _activeDropdownIndex = hasDropdown ? index : null;
    });
  }

  void _onCategoryExit(int index) {
    _scheduleDropdownClose();
  }

  void _onBarExit() {
    _scheduleDropdownClose();
  }

  void _onCategoryTap(int index) {
    _dropdownCloseTimer?.cancel();
    final definition = _categoryDefinitions[index];
    if (definition.dropdownItems.isEmpty) {
      setState(() => _activeDropdownIndex = null);
      return;
    }
    setState(() {
      _activeDropdownIndex = _activeDropdownIndex == index ? null : index;
    });
  }

  void _onDropdownEnter() {
    _dropdownHovering = true;
    _dropdownCloseTimer?.cancel();
  }

  void _onDropdownExit() {
    _dropdownHovering = false;
    _scheduleDropdownClose();
  }

  void _scheduleDropdownClose() {
    _dropdownCloseTimer?.cancel();
    final hasActive = _activeDropdownIndex != null;
    if (!hasActive) {
      return;
    }
    _dropdownCloseTimer = Timer(const Duration(milliseconds: 160), () {
      if (!_dropdownHovering && mounted) {
        setState(() {
          _activeDropdownIndex = null;
        });
      }
    });
  }

  void _showNextBanner() => _updateBannerIndex(1);

  void _showPreviousBanner() => _updateBannerIndex(-1);

  void _scheduleBannerAutoAdvance() {
    _bannerAutoTimer?.cancel();
    if (_promoBannerImages.length <= 1) {
      return;
    }
    _bannerAutoTimer = Timer.periodic(_promoBannerAutoAdvanceDelay, (_) {
      if (!mounted) {
        return;
      }
      _updateBannerIndex(1, restartTimer: false);
    });
  }

  void _updateBannerIndex(int delta, {bool restartTimer = true}) {
    final total = _promoBannerImages.length;
    if (total <= 1) {
      return;
    }
    setState(() {
      _activeBannerIndex = (_activeBannerIndex + delta) % total;
      if (_activeBannerIndex < 0) {
        _activeBannerIndex += total;
      }
    });
    if (restartTimer) {
      _scheduleBannerAutoAdvance();
    }
  }

  @override
  void dispose() {
    _dropdownCloseTimer?.cancel();
    _bannerAutoTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dropdownItems = _activeDropdownItems;
    final hasBanner = _promoBannerImages.isNotEmpty;
    final bannerCount = _promoBannerImages.length;
    final bannerIndex = hasBanner ? _activeBannerIndex % bannerCount : 0;

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
              Container(
                padding: const EdgeInsets.only(
                  left: TopNavBar._outerHPad,
                  right: TopNavBar._outerHPad,
                  top: TopNavBar._topSectionPadTop,
                  bottom: TopNavBar._topSectionPadBottom,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: TopNavBar._logoShiftRight),
                      SizedBox(
                        height: TopNavBar._logoHeight,
                        width: TopNavBar._logoWidth,
                        child: Image.asset(
                          'asset/Sri.png',
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(
                        width:
                            TopNavBar._gapLogoToMenu -
                            TopNavBar._logoShiftRight,
                      ),
                      _NavItem(
                        text: 'Home',
                        fontSize: 14,
                        padding: const EdgeInsets.only(left: 24, right: 14),
                      ),
                      _NavItem(
                        text: 'Offers',
                        fontSize: 14,
                        padding: const EdgeInsets.only(left: 14, right: 24),
                      ),
                      _NavItem(text: 'Sri Rudra Stores'),
                      _NavItem(text: 'Contact Us'),
                      const SizedBox(width: 32),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: TopNavBar._searchMaxWidth,
                        ),
                        child: SizedBox(
                          height: TopNavBar._searchHeight,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 0,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide(
                                  color: theme.colorScheme.primary,
                                  width: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: TopNavBar._gapAfterSearch),
                      _IconBox(
                        tooltip: 'Wishlist',
                        icon: Icons.favorite_border,
                        onTap: () {},
                      ),
                      const SizedBox(width: TopNavBar._gapBetweenIcons),
                      _IconBox(
                        tooltip: 'Cart',
                        icon: Icons.shopping_cart_outlined,
                        onTap: () {},
                      ),
                      const SizedBox(width: TopNavBar._gapBeforeAuth),
                      SizedBox(
                        height: TopNavBar._authHeight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: TopNavBar._authHPad,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                TopNavBar._authRadius,
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Sign Up / Sign In',
                            style: TextStyle(
                              fontSize: TopNavBar._authFontSize,
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
              _CategoryMenuBar(
                activeIndex: _activeDropdownIndex,
                onItemEnter: _onCategoryEnter,
                onItemExit: _onCategoryExit,
                onBarExit: _onBarExit,
                onItemTap: _onCategoryTap,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  if (hasBanner)
                    _PromoBanner(
                      imagePath: _promoBannerImages[bannerIndex],
                      onNext: _showNextBanner,
                      onPrev: _showPreviousBanner,
                      showControls: true,
                      enableNavigation: bannerCount > 1,
                    ),
                  if (dropdownItems.isNotEmpty)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: MouseRegion(
                        onEnter: (_) => _onDropdownEnter(),
                        onExit: (_) => _onDropdownExit(),
                        child: _CategoryDropdown(items: dropdownItems),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 32),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TopNavBar._outerHPad,
                ),
                child: const FeaturedProductsSection(),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TopNavBar._outerHPad,
                ),
                child: const BrassCopperItemsSection(),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TopNavBar._outerHPad,
                ),
                child: const DailyPoojaNeedsSection(),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TopNavBar._outerHPad,
                ),
                child: const FestivalNeedsSection(),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TopNavBar._outerHPad,
                ),
                child: const CategoryHighlightsSection(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
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
          final bool emphasize = text == 'Home' || text == 'Offers';
          return Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 160),
              style: TextStyle(
                fontSize: emphasize ? 18 : fontSize ?? 16,
                fontWeight: emphasize ? FontWeight.w900 : FontWeight.w800,
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
  const _IconBox({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

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
            color: _hover ? const Color(0x0D000000) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: baseBorder,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
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
  final int? activeIndex;
  final void Function(int index) onItemEnter;
  final void Function(int index) onItemExit;
  final VoidCallback onBarExit;
  final void Function(int index) onItemTap;
  const _CategoryMenuBar({
    required this.activeIndex,
    required this.onItemEnter,
    required this.onItemExit,
    required this.onBarExit,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: TopNavBar._categoryHeight),
        alignment: Alignment.centerLeft,
        child: MouseRegion(
          onExit: (_) => onBarExit(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: TopNavBar._outerHPad,
              vertical: TopNavBar._categoryVPad,
            ),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: TopNavBar._categorySpacing,
              runSpacing: TopNavBar._categoryRunSpacing,
              children: [
                for (var i = 0; i < _categoryDefinitions.length; i++)
                  _CategoryButton(
                    category: _categoryDefinitions[i],
                    isActive: activeIndex == i,
                    onEnter: () => onItemEnter(i),
                    onExit: () => onItemExit(i),
                    onTap: () => onItemTap(i),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryButton extends StatefulWidget {
  final _CategoryDefinition category;
  final bool isActive;
  final VoidCallback onEnter;
  final VoidCallback onExit;
  final VoidCallback onTap;
  const _CategoryButton({
    required this.category,
    required this.isActive,
    required this.onEnter,
    required this.onExit,
    required this.onTap,
  });

  @override
  State<_CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<_CategoryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final hasDropdown = widget.category.dropdownItems.isNotEmpty;
    final isHighlighted = widget.isActive || _hover;

    return MouseRegion(
      onEnter: (_) {
        widget.onEnter();
        setState(() => _hover = true);
      },
      onExit: (_) {
        widget.onExit();
        setState(() => _hover = false);
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: EdgeInsets.symmetric(horizontal: TopNavBar._categoryHPad),
          height: TopNavBar._categoryItemHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              TopNavBar._categoryBorderRadius,
            ),
            border: Border.all(
              color: isHighlighted ? Colors.white : Colors.transparent,
              width: 1,
            ),
            color: isHighlighted
                ? Colors.white.withValues(alpha: 0.12)
                : Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.category.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: TopNavBar._categoryTextSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (hasDropdown) ...[
                const SizedBox(width: 6),
                const Icon(Icons.expand_more, color: Colors.white, size: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryDropdown extends StatelessWidget {
  final List<String> items;
  const _CategoryDropdown({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Wrap(
        spacing: 40,
        runSpacing: 18,
        children: [for (final label in items) _DropdownItem(label: label)],
      ),
    );
  }
}

class _DropdownItem extends StatelessWidget {
  final String label;
  const _DropdownItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Container(height: 2, width: 70, color: Colors.orange.shade300),
        ],
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  final String imagePath;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final bool showControls;
  final bool enableNavigation;
  const _PromoBanner({
    required this.imagePath,
    required this.onNext,
    required this.onPrev,
    required this.showControls,
    required this.enableNavigation,
  });

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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imagePath,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: Text(
                          'Missing banner image: $imagePath',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      );
                    },
                  ),
                  if (showControls) ...[
                    _BannerArrowButton(
                      alignment: Alignment.centerLeft,
                      label: '<',
                      onTap: enableNavigation ? onPrev : null,
                    ),
                    _BannerArrowButton(
                      alignment: Alignment.centerRight,
                      label: '>',
                      onTap: enableNavigation ? onNext : null,
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BannerArrowButton extends StatelessWidget {
  final Alignment alignment;
  final String label;
  final VoidCallback? onTap;
  const _BannerArrowButton({
    required this.alignment,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final textColor = Colors.white.withValues(alpha: enabled ? 0.95 : 0.4);

    return Align(
      alignment: alignment,
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: enabled ? 0.35 : 0.18),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 28,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryDefinition {
  final String label;
  final List<String> dropdownItems;
  const _CategoryDefinition(this.label, [this.dropdownItems = const []]);
}

const List<_CategoryDefinition> _categoryDefinitions = [
  _CategoryDefinition('Varalaxmi Vratham', [
    'Decorative Jadalu',
    'Chitti Gajulu',
    'Faces',
    'Bodys',
    'Hands & Legs',
    'Return Gifts',
    'Lotus',
    'Banana Tree',
    'Others',
  ]),
  _CategoryDefinition('One Gram Gold & Silver', [
    'Silver',
    'Gold & Silver',
    'Gold',
  ]),
  _CategoryDefinition('Envelopes & Bags', ['Bags', 'Envelopes']),
  _CategoryDefinition('Peetam & Mandir', ['Peetams', 'Mandir']),
  _CategoryDefinition('Mala & Beads', ['Malas', 'Beads', 'Homam', 'Bracelets']),
  _CategoryDefinition('Books', ['Telugu', 'Hindi']),
  _CategoryDefinition('Homam & Vratham', ['Homam', 'Vratham']),
  _CategoryDefinition('Cloth Items', [
    'Cloth Items',
    'Dhoti',
    'Towel & Shawl',
    'Blouse',
    'Gifting',
    'Backdrops',
  ]),
  _CategoryDefinition('Fiber & Steel Items', ['Steel Items', 'Fiber Items']),
  _CategoryDefinition('Garlands', ['Garlands']),
  _CategoryDefinition('Decorative & Marriage Items', [
    'Decorative Items',
    'Marriage Items',
  ]),
  _CategoryDefinition('Photos Frames & Yantras', [
    'Gifting',
    'Yantras',
    'Photo Frames',
  ]),
  _CategoryDefinition('Sphatika & Maragaj Items', [
    'Sphatika & Maragaj Items',
    'Stone Items',
    'Sphatika Items',
    'Maragaj Items',
  ]),
  _CategoryDefinition('German Silver', [
    'German Silver Items',
    'Gift Articles',
  ]),
  _CategoryDefinition('Festival Needs', [
    'Durgaashtami',
    'Ganesh Chaturthi',
    'Dasera',
    'Diwali Needs',
    'Sankranthi',
    'Shivarathri',
    'Sri Rama Navami',
    'Ugadi Needs',
    'Karthika Masam',
    'Ayyappa',
    'Krishna',
  ]),
  _CategoryDefinition('Daily Pooja Needs', [
    'Powder',
    'Agarbatti & Dhoop',
    'Wicks',
    'Deepam Oil',
    'Camphor & Camphor Cones',
    'Tikas & Jars',
    'Zodiac Agarbatti',
    'Wooden',
    'Lamination',
    'Gifting',
    'Attar Bottles',
    'Return Gifts',
  ]),
  _CategoryDefinition('Brass & Copper Items', ['Brass', 'Idols', 'Copper']),
  _CategoryDefinition('Others', ['Others']),
];
