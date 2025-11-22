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
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      elevation: 0,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: _vPad),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left shift before logo (moves only the logo)
              SizedBox(width: _logoShiftRight),
              // Logo
              SizedBox(
                height: _logoHeight,
                child: Transform.scale(
                  scaleX: _logoScaleX,
                  scaleY: 1.0,
                  child: Image.asset('asset/Sri.png', fit: BoxFit.fitHeight),
                ),
              ),
              // Keep overall alignment: reduce post-logo gap by the amount we shifted right
              SizedBox(width: _gapLogoToMenu - _logoShiftRight),
              // Menu items (moved to right side)
              _NavItem(text: 'Home', fontSize: 14, padding: const EdgeInsets.only(left: 24, right: 14)),
              _NavItem(text: 'Offers', fontSize: 14, padding: const EdgeInsets.only(left: 14, right: 24)),
              _NavItem(text: 'Sri Rudra Stores'),
              _NavItem(text: 'Contact Us'),
              const SizedBox(width: 32),
              // Search bar
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
              // Icons styled like provided image
              _IconBox(
                tooltip: 'Wishlist',
                icon: Icons.favorite_border,
                onTap: () {},
              ),
              // Space between wishlist and cart
              SizedBox(width: _gapBetweenIcons),
              _IconBox(
                tooltip: 'Cart',
                icon: Icons.shopping_cart_outlined,
                onTap: () {},
              ),
              // Gap before auth button
              SizedBox(width: _gapBeforeAuth),
              // Sign Up / Sign In button
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_logoHeight + _vPad * 2);
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