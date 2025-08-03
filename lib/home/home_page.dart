import 'package:flutter/material.dart';
import 'package:task_two/auth/signup_page.dart';
import 'package:task_two/home/account_page.dart';
import 'package:task_two/home/bookings_page.dart';
import 'package:task_two/home/offers_page.dart';
import 'package:video_player/video_player.dart';
import 'categories_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedBottomNavIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const CategoriesPage(),
    const BookingsPage(),
    const OffersPage(),
    const AccountPage(),
  ];

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedBottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_selectedBottomNavIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedBottomNavIndex,
        onItemTapped: _onBottomNavItemTapped,
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String _selectedCategory = 'HOBBSEEME';

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    selectedCategory: _selectedCategory,
                    onCategorySelected: _onCategorySelected,
                  ),
                  const SearchBarWidget(),
                  const SizedBox(height: 16),
                  const AdCarousel(),
                  const SectionHeader(
                    title: 'POPULAR COURSE CATEGORIES',
                  ),
                  const PopularCategories(),
                  const SectionHeader(
                    title: 'FIND WHAT FITS YOU',
                  ),
                  const FindWhatFitsYou(),
                  const SectionHeader(
                    title: 'RECOMMENDED CLASSES',
                    subtitle: 'Explore Enhance Your Experience',
                  ),
                  RecommendedList(
                    itemCount: 6,
                    itemBuilder: (context, index) =>
                        const RecommendedClassCard(),
                  ),
                  const SimpleSeeAllButton(title: 'See All Classes'),
                  const SectionHeader(
                      title: 'RECOMMENDED EXPERIENCES',
                      subtitle: 'Explore Enhance Your Experience'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        return const RecommendedExperienceCard();
                      },
                    ),
                  ),
                  const SimpleSeeAllButton(title: 'See All Experiences'),
                  const GiftVoucherCard(),
                  const FreeClassCard(),
                  const SizedBox(height: 20),
                  const DubaiExperienceCard(),
                ],
              ),
            ),
          ),
          const SignUpBanner(),
        ],
      ),
    );
  }
}

class SimpleSeeAllButton extends StatelessWidget {
  final String title;

  const SimpleSeeAllButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF2C2C2E),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          // Set a minimum height for the button
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () {},
        // Using a Stack for precise control over element positions
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Images aligned to the far left
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 70,
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage('assets/p1.png'),
                    ),
                    const Positioned(
                      left: 20,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage('assets/p2.png'),
                      ),
                    ),
                    const Positioned(
                      left: 40,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage('assets/p3.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Text is automatically centered within the Stack
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            // 3. Icon aligned to the far right
            const Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.north_east, color: Colors.yellow, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendedExperienceCard extends StatelessWidget {
  const RecommendedExperienceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1C1C1E),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/category_cover.png',
                // height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Wellness & Lifestyle Adven.',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Art & Soul Portrait Workshop',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 8),
                const Text('Only 50 Slots Left!',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.yellow),
                    const SizedBox(width: 4),
                    const Text('Alive Park, Dubai',
                        style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 14, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    const Text('Sat, May 10, 07:00 PM',
                        style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('FROM AED 456',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FindWhatFitsYou extends StatelessWidget {
  const FindWhatFitsYou({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: const [
          FitCard(
              imagePath: 'assets/online_classes.png', title: 'ONLINE CLASSES'),
          FitCard(imagePath: 'assets/kids.png', title: 'KIDS'),
          FitCard(imagePath: 'assets/couple.png', title: 'COUPLES'),
          FitCard(imagePath: 'assets/adventure.png', title: 'ADVENTURE'),
          FitCard(imagePath: 'assets/online_classes.png', title: 'NEWBIES'),
        ],
      ),
    );
  }
}

class FitCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const FitCard({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CustomAppBar({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: Colors.yellow, size: 20),
                SizedBox(width: 8),
                Text(
                  'Jumaira beach residency, Dubai',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryButton(
                text: 'Hobbseeme',
                isSelected: selectedCategory == 'HOBBSEEME',
                onTap: () => onCategorySelected('HOBBSEEME'),
                assetPath: 'assets/logo.png',
              ),
              CategoryButton(
                text: 'CLASSES',
                isSelected: selectedCategory == 'CLASSES',
                onTap: () => onCategorySelected('CLASSES'),
                assetPath: 'assets/classes_logo.png',
              ),
              CategoryButton(
                text: 'EXPERIENCES',
                isSelected: selectedCategory == 'EXPERIENCES',
                onTap: () => onCategorySelected('EXPERIENCES'),
                assetPath: 'assets/experience_logo.png',
              ),
              CategoryButton(
                text: 'EVENTS',
                isSelected: selectedCategory == 'EVENTS',
                onTap: () => onCategorySelected('EVENTS'),
                assetPath: 'assets/event_logo.png',
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final String assetPath;

  const CategoryButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 85,
        height: 85,
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(24),
          border:
              isSelected ? Border.all(color: Colors.yellow, width: 2.0) : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.yellow.withOpacity(0.6),
                    blurRadius: 15,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.0),
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
            scale: 1.5,
          ),
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 15),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for classes, tutors, events, etc',
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset('assets/bee.gif', height: 25),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 14, 14, 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade700, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade500, width: 1.2),
          ),
        ),
      ),
    );
  }
}

class AdCarousel extends StatelessWidget {
  const AdCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView(
        controller: PageController(viewportFraction: 0.9),
        children: [
          AdCard(imagePath: 'assets/ad_banner_1.png'),
          AdCard(imagePath: 'assets/ad_banner_2.png'),
          AdCard(imagePath: 'assets/ad_banner_1.png'),
          AdCard(imagePath: 'assets/ad_banner_3.png'),
        ],
      ),
    );
  }
}

class AdCard extends StatelessWidget {
  final String imagePath;
  const AdCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                ),
              ]
            ],
          ),
          Image.asset('assets/yellow_arrow.png', height: 30)
        ],
      ),
    );
  }
}

class PopularCategories extends StatelessWidget {
  const PopularCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: const [
          CategoryCard(
            imagePath: 'assets/art.png',
            title: 'ART & CRAFT',
            backgroundColor: Colors.blue,
          ),
          CategoryCard(
              imagePath: 'assets/cooking.png',
              title: 'COOKING',
              backgroundColor: Colors.pink),
          CategoryCard(
              imagePath: 'assets/music.png',
              title: 'MUSIC',
              backgroundColor: Color.fromARGB(255, 6, 241, 194)),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final Color backgroundColor;

  const CategoryCard(
      {super.key,
      required this.imagePath,
      required this.backgroundColor,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: backgroundColor,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendedList extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const RecommendedList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    int half = (itemCount / 2).ceil();

    return SizedBox(
      // height: 720 * 0.5,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(half, (i) {
            return Column(
              children: [
                itemBuilder(context, i),
                const SizedBox(height: 12),
                if (i + half < itemCount) itemBuilder(context, i + half),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class RecommendedClassCard extends StatelessWidget {
  const RecommendedClassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Card(
        color: const Color(0xFF1C1C1E),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/dance.jpg',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border,
                        color: Colors.white, size: 20),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: Colors.purpleAccent, width: 1),
                        ),
                        child: const Text('Dance',
                            style: TextStyle(
                                color: Colors.purpleAccent, fontSize: 12)),
                      ),
                      const Text('In Studio',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Bollywood Dance Sessions',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 4),
                  const Text('By Taal',
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('24% OFF',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'AED 567',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.white54,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('AED 456',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GiftVoucherCard extends StatefulWidget {
  const GiftVoucherCard({super.key});

  @override
  State<GiftVoucherCard> createState() => _GiftVoucherCardState();
}

class _GiftVoucherCardState extends State<GiftVoucherCard> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/gift_background.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _controller.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : Container(color: Colors.black),
            Container(
              color: Colors.black.withOpacity(0.3),
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'SKIP THE USUAL GIFTS',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'GIVE YOUR LOVED ONES MEMORIES.',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('GET GIFT VOUCHER'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FreeClassCard extends StatelessWidget {
  const FreeClassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/free_class.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const Center(
            child: Text(
              'BOOK YOUR 1ST FREE CLASS',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'As a new user, you can book a free class with Hobbeeme!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('BOOK NOW'),
          ),
        ],
      ),
    );
  }
}

class SignUpBanner extends StatelessWidget {
  const SignUpBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 16, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/signup_logo.gif', height: 25),
              const SizedBox(width: 12),
              const Text(
                'Sign up to personalise your experience!',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Sign up',
              style: TextStyle(height: 2.8),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Color(0xFF2C2C2E), width: 1.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.grid_view_rounded, 'Categories', 1),
            _buildNavItem(Icons.confirmation_number_outlined, 'Bookings', 2),
            _buildNavItem(Icons.local_offer_outlined, 'Offers', 3),
            _buildNavItem(Icons.account_circle_outlined, 'Account', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.yellow : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.yellow : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DubaiExperienceCard extends StatelessWidget {
  const DubaiExperienceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/dubai.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
