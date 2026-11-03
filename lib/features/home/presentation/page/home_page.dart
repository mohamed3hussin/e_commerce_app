
import 'package:e_commerce_app/features/home/presentation/widgets/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/dependency_injection/injection_container.dart';
import 'package:e_commerce_app/features/home/presentation/cubit/product_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductCubit>()..getProducts(),
      child: Scaffold(

        body: HomeView(),
      ),
    );
  }
}
