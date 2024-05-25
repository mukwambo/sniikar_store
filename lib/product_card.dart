import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName, image;
  final double productPrice;
  const ProductCard({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    /* You can either choose to use a card or a container, in this case, i will go ahead with the container
    since the card comes with an elevation which i don't want. You can still edit the card and remove the
    elevation but why do all that work if you can simply use a container?
     */
    return Container(
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 120,
          ),
          const SizedBox(height: 10),
          Text(
            productName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Text('\$$productPrice'),
        ],
      ),
    );
  }
}
