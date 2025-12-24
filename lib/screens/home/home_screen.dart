import 'package:bt_management_flutter/screens/inventory/inventory_screen.dart';
import 'package:bt_management_flutter/screens/product/product_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            top: true,
            child: TabBar(
              unselectedLabelColor: Colors.black,
              indicatorColor:Colors.blue,
              labelColor: Colors.blue,
              tabs: const [
                Tab(
                  icon: Text('Sản phẩm'),
                ),
                Tab(
                  icon: Text('Tồn kho'),
                ),
              ],
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                ProductScreen(),
                InventoryScreen()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
