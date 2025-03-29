import 'package:auto_route/annotations.dart';
import 'package:canteen/features/debts/presentation/debts_page.dart';
import 'package:canteen/features/delivery/presentation/delivery_page.dart';
import 'package:canteen/features/discount/presentation/discount_page.dart';
import 'package:canteen/features/recomendations/presentation/recommendations_page.dart';
import 'package:canteen/features/schedule/domain/presentation/catalogue_page.dart';
import 'package:canteen/features/schedule/presentation/admin_schedule.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

const List<String> iconsPath = [
  'assets/icons/recommendation_icon.png',
  'assets/icons/schedule_icon.png',
  'assets/icons/products_icon.png',
  'assets/icons/debt_icon.png',
  'assets/icons/delivery_icon.png',
];

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final Map<String, Widget> _pages = {
    'Recommendations': const RecommendationsPage(),
    'Schedule': const AdminSchedulePage(),
    'Category': const CataloguePage(),
    'Debts': const DebtsPage(),
    'Delivery': const DeliveryPage(),
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _pages.length,
      vsync: this,
      initialIndex: _currentIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                color: Colors.white,
              ),
              Image.asset(
                'assets/layouts/home_back.png',
                fit: BoxFit.cover,
                width: size.width,
              ),
            ],
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: _pages.values.toList(),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: _currentIndex,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Colors.green,
            items: iconsPath.map((path) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  path,
                  width: 30,
                  color: iconsPath.indexOf(path) == _currentIndex
                      ? Colors.white
                      : Colors.grey,
                  height: 30,
                ),
              );
            }).toList(),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _tabController.animateTo(index);
              });
            },
          ),
        ),
      ],
    );
  }
}
