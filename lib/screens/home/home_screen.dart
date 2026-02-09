import 'dart:developer';

import 'package:bt_management_flutter/screens/inventory/inventory_screen.dart';
import 'package:bt_management_flutter/screens/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? tabController;
  String appGroupId = 'group.com.izisolution.btmanagement.cicd';
  String iOSWidgetName = 'MyHomeWidget';
  String androidWidgetName = 'MyHomeWidget';
  String dataKey = 'text_from_flutter';

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    initHomeWidget();
  }

  void initHomeWidget() async {
    final isInit = await HomeWidget.setAppGroupId(appGroupId);
    log('isInit $isInit');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            top: true,
            child: TabBar(
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.blue,
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
              children: const [ProductScreen(), InventoryScreen()],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
