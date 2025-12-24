import 'package:bt_management_flutter/screens/cart/cart_screen.dart';
import 'package:bt_management_flutter/screens/customer/customer_screen.dart';
import 'package:bt_management_flutter/screens/home/home_screen.dart';
import 'package:bt_management_flutter/screens/main/bloc/main_bloc.dart';
import 'package:bt_management_flutter/screens/order_list/order_list_screen.dart';
import 'package:bt_management_flutter/screens/qr_screen/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'widgets/bottom_navigation_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(const MainState()),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: const _BottomNavigationBar(),
      body: PageView(
        onPageChanged: (pageChange) {
          context
              .read<MainBloc>()
              .add(UpdatePageChangeEvent(pageChange: pageChange));
        },
        controller: context.read<MainBloc>().pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          // ProductScreen(),
          HomeScreen(),
          CartScreen(),
          OrderListScreen(),
          CustomerScreen(),
          QrScreen()
          // SizedBox.shrink()
          // InventoryScreen()
        ],
      ),
    );
  }
}
