import 'package:evertec_technical_test/features/home/presentation/cubits/detail/detail_product_cubit.dart';
import 'package:evertec_technical_test/features/home/presentation/cubits/detail/detail_product_state.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/detail/sections/detail_app_bar.dart';
import 'package:evertec_technical_test/features/home/presentation/screens/detail/sections/detail_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailProductCubit, DetailProductState>(
        builder: (context, state) {
          return state.when(
            initial: () => SizedBox.shrink(),
            loading: () => Center(child: CircularProgressIndicator()),
            loaded: (product, isOffline, isFromCache) {
              return CustomScrollView(
                physics: ClampingScrollPhysics(),
                slivers: [
                  DetailAppBar(product: product),
                  DetailInfo(product: product),
                ],
              );
            },
            error: (message, isOffline) => Center(child: Text(message)),
          );
        },
      ),
    );
  }
}
