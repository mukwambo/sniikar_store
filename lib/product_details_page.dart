import 'dart:ui';

import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final Map<String, Object> product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
        ),
      ),
      body: Column(
        children: [
          Text(
            product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset(product['imageUrl'] as String),
          ),
          const Spacer(flex: 2),
          Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(200, 200, 200, 0.2),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Center(
                  child: Text(
                    '\$${product['price']}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (product['sizes'] as List<int>).length,
                      itemBuilder: (context, index) {
                        final size = (product['sizes'] as List<int>)[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            label: Text(size.toString()),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  child: const Text(
                    'Add to cart',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
