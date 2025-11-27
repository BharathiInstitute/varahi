import 'dart:async';

import 'package:flutter/material.dart';

const double _cardWidth = 220;
const double _cardHeight = 340;
const double _imageHeight = 150;
const double _scrollAmount = 240;
const double _cardSpacing = 16;

const double _highlightCardWidth = 380;
const double _highlightCardHeight = 180;
const double _highlightCardSpacing = 18;
const Duration _highlightAutoScrollDelay = Duration(seconds: 4);

class ProductCardData {
  final String title;
  final String description;
  final String price;
  final String compareAtPrice;
  final String discount;
  final String imagePath;

  const ProductCardData({
    required this.title,
    required this.description,
    required this.price,
    required this.compareAtPrice,
    required this.discount,
    required this.imagePath,
  });
}

class CategoryHighlightData {
  final String title;
  final String caption;
  final String imagePath;
  final Color startColor;
  final Color endColor;

  const CategoryHighlightData({
    required this.title,
    required this.caption,
    required this.imagePath,
    required this.startColor,
    required this.endColor,
  });
}

const List<ProductCardData> _othersProducts = [
  ProductCardData(
    title: 'Badam Nuts',
    description: 'Sri Rudra Badam Nuts are 100% natural an...',
    price: '₹90',
    compareAtPrice: '₹100',
    discount: '10% OFF',
    imagePath: 'asset/varahi2.png',
  ),
  ProductCardData(
    title: 'Jala Deepalu',
    description: 'Handmade with detailing, Sri Rudra Jala...',
    price: '₹53',
    compareAtPrice: '₹59',
    discount: '10% OFF',
    imagePath: 'asset/varahi3.png',
  ),
  ProductCardData(
    title: 'Gomathi Chekram',
    description: 'Sri Rudra Gomathi Chakram is a white col...',
    price: '₹225',
    compareAtPrice: '₹250',
    discount: '10% OFF',
    imagePath: 'asset/varahi4.png',
  ),
  ProductCardData(
    title: 'Golden DI Cut Sticker',
    description: 'The Sri Rudra 3X8 Golden DI Cut Sticker...',
    price: '₹17',
    compareAtPrice: '₹19',
    discount: '10% OFF',
    imagePath: 'asset/varahi5.png',
  ),
  ProductCardData(
    title: 'White Rose Flowers',
    description: 'Sri Rudra White Rose Flower Pearls 108 a...',
    price: '₹97',
    compareAtPrice: '₹108',
    discount: '10% OFF',
    imagePath: 'asset/varahi6.png',
  ),
];

const List<ProductCardData> _brassCopperProducts = [
  ProductCardData(
    title: 'Aarthi Diyas (N-4)',
    description: 'Sri Rudra Aarthi Diyas is a pure brass i...',
    price: '₹237',
    compareAtPrice: '₹339',
    discount: '30% OFF',
    imagePath: 'asset/varahi2.png',
  ),
  ProductCardData(
    title: 'Ashta Lakshmi Chembu',
    description: 'Sri Rudra Ashta Lakshmi Chembu is a fine...',
    price: '₹953',
    compareAtPrice: '₹1,059',
    discount: '10% OFF',
    imagePath: 'asset/varahi3.png',
  ),
  ProductCardData(
    title: 'Chambu (S)',
    description: 'A finely crafted brass chambu (Height...',
    price: '₹270',
    compareAtPrice: '₹385',
    discount: '30% OFF',
    imagePath: 'asset/varahi4.png',
  ),
  ProductCardData(
    title: 'Damaru Panchapatra',
    description: 'A sacred brass panchapatra designed wit...',
    price: '₹118',
    compareAtPrice: '₹169',
    discount: '30% OFF',
    imagePath: 'asset/varahi5.png',
  ),
  ProductCardData(
    title: 'Dattatreya Swamy',
    description: 'An exquisitely carved brass idol of Lord...',
    price: '₹1,309',
    compareAtPrice: '₹1,870',
    discount: '30% OFF',
    imagePath: 'asset/varahi6.png',
  ),
];

const List<ProductCardData> _dailyPoojaNeedsProducts = [
  ProductCardData(
    title: '365 Linga Wicks',
    description: 'Light up your prayers with Sri Rudra 365...',
    price: '₹35',
    compareAtPrice: '₹39',
    discount: '10% OFF',
    imagePath: 'asset/varahi2.png',
  ),
  ProductCardData(
    title: '365 Plain Wicks',
    description: 'Crafted from premium cotton, these wicks...',
    price: '₹15',
    compareAtPrice: '₹29',
    discount: '50% OFF',
    imagePath: 'asset/varahi3.png',
  ),
  ProductCardData(
    title: 'Chandan',
    description: 'Made from 100% natural sandalwood, Sri R...',
    price: '₹32',
    compareAtPrice: '₹35',
    discount: '10% OFF',
    imagePath: 'asset/varahi4.png',
  ),
  ProductCardData(
    title: 'Dhoop Cones',
    description: 'Experience positivity and peace with Sri...',
    price: '₹32',
    compareAtPrice: '₹35',
    discount: '10% OFF',
    imagePath: 'asset/varahi7.png',
  ),
  ProductCardData(
    title: 'Flora Agarbathi',
    description: 'Experience refreshing atmosphere with fl...',
    price: '₹26',
    compareAtPrice: '₹29',
    discount: '10% OFF',
    imagePath: 'asset/varahi8.png',
  ),
];

const List<ProductCardData> _festivalNeedsProducts = [
  ProductCardData(
    title: '5 Diya Hati',
    description: 'A stunning-themed diya plate designed f...',
    price: '₹179',
    compareAtPrice: '',
    discount: '',
    imagePath: 'asset/varahi2.png',
  ),
  ProductCardData(
    title: 'Ayyappa Dress',
    description: 'Sri Rudra Ayyappa Dress (SR 01400) is a ...',
    price: '₹400',
    compareAtPrice: '',
    discount: '',
    imagePath: 'asset/varahi3.png',
  ),
  ProductCardData(
    title: 'Erumudi Bag',
    description: 'Designed for Ayyappa Mala Swamis, the Sr...',
    price: '₹53',
    compareAtPrice: '₹59',
    discount: '10% OFF',
    imagePath: 'asset/varahi4.png',
  ),
  ProductCardData(
    title: 'Krishna Dress',
    description: 'Decorate your Krishna idol with this bea...',
    price: '₹219',
    compareAtPrice: '',
    discount: '',
    imagePath: 'asset/varahi5.png',
  ),
  ProductCardData(
    title: 'Pagdi 5 Size',
    description: 'Give your Krishna idol a royal touch wit...',
    price: '₹89',
    compareAtPrice: '',
    discount: '',
    imagePath: 'asset/varahi6.png',
  ),
];

const List<CategoryHighlightData> _categoryHighlights = [
  CategoryHighlightData(
    title: 'Garlands',
    caption: 'German Silver',
    imagePath: 'asset/varahi2.png',
    startColor: Color(0xFFE53935),
    endColor: Color(0xFFFFB300),
  ),
  CategoryHighlightData(
    title: 'Steel & Fiber',
    caption: 'Decor Essentials',
    imagePath: 'asset/varahi3.png',
    startColor: Color(0xFFFF9800),
    endColor: Color(0xFFFFCC80),
  ),
  CategoryHighlightData(
    title: 'Books',
    caption: 'Pooja Guidance',
    imagePath: 'asset/varahi4.png',
    startColor: Color(0xFFD32F2F),
    endColor: Color(0xFFFFA726),
  ),
  CategoryHighlightData(
    title: 'Daily Pooja Needs',
    caption: 'Essentials Delivered',
    imagePath: 'asset/varahi2.png',
    startColor: Color(0xFFFF8A00),
    endColor: Color(0xFFFFC107),
  ),
  CategoryHighlightData(
    title: 'Homam & Vratham',
    caption: 'Sacred Ritual Kits',
    imagePath: 'asset/varahi3.png',
    startColor: Color(0xFFC62828),
    endColor: Color(0xFFFF7043),
  ),
  CategoryHighlightData(
    title: 'Sphatika & Maragaj',
    caption: 'Crystal Collections',
    imagePath: 'asset/varahi4.png',
    startColor: Color(0xFFFF8A00),
    endColor: Color(0xFFFFD180),
  ),
];

class ProductCarouselSection extends StatefulWidget {
  final String title;
  final String viewAllLabel;
  final List<ProductCardData> products;
  final VoidCallback? onViewAll;

  const ProductCarouselSection({
    required this.title,
    required this.viewAllLabel,
    required this.products,
    this.onViewAll,
    super.key,
  });

  @override
  State<ProductCarouselSection> createState() => _ProductCarouselSectionState();
}

class _ProductCarouselSectionState extends State<ProductCarouselSection> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: widget.onViewAll ?? () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.viewAllLabel,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _ProductArrowButton(
              icon: Icons.chevron_left,
              onTap: () => _scrollBy(-_scrollAmount),
            ),
            Expanded(
              child: SizedBox(
                height: _cardHeight,
                child: ListView.separated(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final product = widget.products[index];
                    return _ProductCard(product: product);
                  },
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: _cardSpacing),
                  itemCount: widget.products.length,
                ),
              ),
            ),
            _ProductArrowButton(
              icon: Icons.chevron_right,
              onTap: () => _scrollBy(_scrollAmount),
            ),
          ],
        ),
      ],
    );
  }

  void _scrollBy(double offset) {
    if (!_controller.hasClients) {
      return;
    }
    final target = (_controller.offset + offset)
        .clamp(0.0, _controller.position.maxScrollExtent)
        .toDouble();
    _controller.animateTo(
      target,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
    );
  }
}

class FeaturedProductsSection extends StatelessWidget {
  const FeaturedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductCarouselSection(
      title: 'Others',
      viewAllLabel: 'View All (7)',
      products: _othersProducts,
    );
  }
}

class BrassCopperItemsSection extends StatelessWidget {
  const BrassCopperItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductCarouselSection(
      title: 'Brass & Copper Items',
      viewAllLabel: 'View All (95)',
      products: _brassCopperProducts,
    );
  }
}

class DailyPoojaNeedsSection extends StatelessWidget {
  const DailyPoojaNeedsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductCarouselSection(
      title: 'Daily Pooja Needs',
      viewAllLabel: 'View All (201)',
      products: _dailyPoojaNeedsProducts,
    );
  }
}

class FestivalNeedsSection extends StatelessWidget {
  const FestivalNeedsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductCarouselSection(
      title: 'Festival Needs',
      viewAllLabel: 'View All (100)',
      products: _festivalNeedsProducts,
    );
  }
}

class CategoryHighlightsSection extends StatefulWidget {
  const CategoryHighlightsSection({super.key});

  @override
  State<CategoryHighlightsSection> createState() =>
      _CategoryHighlightsSectionState();
}

class _CategoryHighlightsSectionState extends State<CategoryHighlightsSection> {
  final ScrollController _controller = ScrollController();
  Timer? _autoScrollTimer;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleScrollUpdate);
    _startAutoScroll();
  }

  void _handleScrollUpdate() {
    if (!_controller.hasClients) {
      return;
    }
    final double itemExtent = _highlightCardWidth + _highlightCardSpacing;
    if (itemExtent <= 0) {
      return;
    }
    final int index = (_controller.offset / itemExtent).round().clamp(
      0,
      _categoryHighlights.length - 1,
    );
    if (index != _activeIndex) {
      setState(() => _activeIndex = index);
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (_categoryHighlights.length <= 1) {
      return;
    }
    _autoScrollTimer = Timer.periodic(
      _highlightAutoScrollDelay,
      (_) => _scrollNext(),
    );
  }

  void _scrollNext() {
    if (!_controller.hasClients) {
      return;
    }
    final int nextIndex = (_activeIndex + 1) % _categoryHighlights.length;
    final double rawOffset =
        nextIndex * (_highlightCardWidth + _highlightCardSpacing);
    final double maxOffset = _controller.position.maxScrollExtent;
    final double targetOffset = rawOffset.clamp(0.0, maxOffset);
    _controller.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.removeListener(_handleScrollUpdate);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_categoryHighlights.isEmpty) {
      return const SizedBox.shrink();
    }

    final String caption = _categoryHighlights[_activeIndex].caption;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: _highlightCardHeight,
          child: ListView.separated(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(right: 32),
            itemBuilder: (context, index) {
              final highlight = _categoryHighlights[index];
              return _CategoryHighlightCard(
                highlight: highlight,
                width: _highlightCardWidth,
                height: _highlightCardHeight,
              );
            },
            separatorBuilder: (_, __) =>
                const SizedBox(width: _highlightCardSpacing),
            itemCount: _categoryHighlights.length,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(
                caption,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'View All (48)',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CategoryHighlightCard extends StatelessWidget {
  final CategoryHighlightData highlight;
  final double width;
  final double height;

  const _CategoryHighlightCard({
    required this.highlight,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final Color overlayStart = highlight.startColor.withValues(alpha: 0.92);
    final Color overlayEnd = highlight.endColor.withValues(alpha: 0.92);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [highlight.startColor, highlight.endColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [overlayStart, overlayEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Text(
                    highlight.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.45,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        highlight.imagePath,
                        fit: BoxFit.cover,
                        height: height,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductCardData product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _cardWidth,
      height: _cardHeight,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8E8E8)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x15000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: _cardWidth / _imageHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(product.imagePath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                product.price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              if (product.compareAtPrice.isNotEmpty) ...[
                const SizedBox(width: 8),
                Text(
                  product.compareAtPrice,
                  style: const TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.black45,
                  ),
                ),
              ],
              if (product.discount.isNotEmpty) ...[
                const SizedBox(width: 6),
                Text(
                  product.discount,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
              ],
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.orange,
                    side: const BorderSide(color: Colors.orange, width: 1.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProductArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ProductArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.orange, width: 2),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.orange, size: 22),
      ),
    );
  }
}
