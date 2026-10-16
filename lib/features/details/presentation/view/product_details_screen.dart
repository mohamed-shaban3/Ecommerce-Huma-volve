import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/theme.dart';
import 'package:ecommerce_app_huma_volve/core/widgets/primary_button.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/data_source/product_details_remote_data_source_imp.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/repository/product_details_repository_imp.dart';
import 'package:ecommerce_app_huma_volve/features/details/domain/use_cases/get_product_details_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/view/widgets/color_selector.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/view/widgets/share_product_button.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/view/widgets/size_selector.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/view_model/cubit/product_details_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/view_model/cubit/product_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId; 

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(
        GetProductDetailsUseCase(
          ProductDetailsRepositoryImp(
            remoteDataSource: ProductDetailsRemoteDataSourceImp(
              apiClient: ApiClient(),
            ),
          ),
        ),
      )..getProductDetails(productId),
      child:  ProductDetailsView(productId: productId),
    );
  }
}

class ProductDetailsView extends StatefulWidget {
  final int productId;
  const ProductDetailsView({super.key, required this.productId});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late Color _selectedColor;
  late String _selectedSize;

  final List<Color> dummyColors = [Colors.black, Colors.blue, Colors.grey];
  final List<String> dummySizes = ['S', 'M', 'L', 'XL'];

  @override
  void initState() {
    super.initState();
    _selectedColor = dummyColors.first;
    _selectedSize = dummySizes.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
     
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsStates>(
        builder: (context, state) {
          if (state is ProductDetailsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppTheme.primary),
            );
          } else if (state is ProductDetailsErrorState) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (state is ProductDetailsSuccessState) {
            final product = state.product;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  pinned: true,
                  backgroundColor: AppTheme.background,
                  leading: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 16),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.favorite_border, size: 18),
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 4),
                    ShareProductButton(productId: widget.productId.toString()),
                    const SizedBox(width: 8),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: 'product-${product.id}',
                      child: Image.network(
                        product.images?.isNotEmpty == true
                            ? product.images![0]
                            : '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.image_not_supported)),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(32)),
                    ),
                    transform: Matrix4.translationValues(0.0, -32.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  product.title ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(fontSize: 28, height: 1.2),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '\$${product.price?.toDouble().toStringAsFixed(2) ?? '0.00'}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                        color: AppTheme.primary, fontSize: 24),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Description',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(height: 1.6, fontSize: 16),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Select Color',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          ColorSelector(
                            colors: dummyColors,
                            selectedColor: _selectedColor,
                            onColorSelected: (color) {
                              setState(() {
                                _selectedColor = color;
                              });
                            },
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Select Size',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          SizeSelector(
                            sizes: dummySizes,
                            selectedSize: _selectedSize,
                            onSizeSelected: (size) {
                              setState(() {
                                _selectedSize = size;
                              });
                            },
                          ),
                          const SizedBox(height: 32),
                          PrimaryButton(
                            text: 'Add to Cart',
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.title ?? ''} added to cart',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: AppTheme.primary,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}