import 'package:flutter/material.dart';
import 'package:gov_ease/core/constants/app_colors.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    Center(child: Text('شاشة حسابي', style: TextStyle(fontSize: 16))),
    Center(child: Text('شاشة حجوزاتي', style: TextStyle(fontSize: 16))),
    Center(child: Text('شاشة الخدمات', style: TextStyle(fontSize: 16))),
    Center(child: Text('شاشة الرئيسية', style: TextStyle(fontSize: 16))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5E7EB), width: 1.0)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Icons.person_outline_rounded,
                  label: 'حسابي',
                ),
                _buildNavItem(
                  index: 1,
                  icon: Icons.confirmation_number_outlined,
                  label: 'حجوزاتي',
                ),
                _buildNavItem(
                  index: 2,
                  icon: Icons.grid_view_rounded,
                  label: 'الخدمات',
                ),
                _buildNavItem(
                  index: 3,
                  icon: Icons.home_rounded,
                  label: 'الرئيسية',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = _currentIndex == index;
    const Color activeColor = AppColors.actionBlue;
    const Color inactiveColor = Color(0xFF64748B);

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 3,
            width: 28,
            decoration: BoxDecoration(
              color: isSelected ? activeColor : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 6),

          Icon(icon, size: 24, color: isSelected ? activeColor : inactiveColor),
          const SizedBox(height: 4),

          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}
