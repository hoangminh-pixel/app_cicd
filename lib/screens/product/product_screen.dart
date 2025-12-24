import 'package:bt_management_flutter/components/app_bar.dart';
import 'package:bt_management_flutter/core/utils/formatter.dart';
import 'package:bt_management_flutter/data/models/product.dart';
import 'package:bt_management_flutter/screens/product/bloc/product_bloc.dart';
import 'package:bt_management_flutter/screens/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'widgets/body.dart';
part './widgets/product_item.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(),
      child: const _Body(),
    );
  }
}
