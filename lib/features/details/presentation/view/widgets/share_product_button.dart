import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
class ShareProductButton extends StatelessWidget {
  final String productId;
  const ShareProductButton({ required this.productId});
  @override

  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final productLink=" https://ecommerce-huma-volve-app.web.app/products/$productId"; ;
        final String shareMessage = 'Look at this Product: $productLink';
        await SharePlus.instance.share(
          ShareParams(
            text: shareMessage,
            subject: 'Check out this Product on Huma Volve',
          ),
        );
      },
      icon: const Icon(Icons.share),
    );    
  }
}
