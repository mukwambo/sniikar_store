import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sniikar_store/cart_Provider.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedSize = 0;

  void onTap() {
    /* The if statement helps check if the user has selected the shoe size,
    if not, upon clicking the add to cart button the snackBar text is displayed,
    otherwise the product is added to cart
    */
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct({
        'id': widget.product['id'],
        'company': widget.product['company'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'imageUrl': widget.product['imageUrl'],
        'size': selectedSize,
      });
      // Display a message to confirm that the product has been added to cart
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          content: Text(
            'Product added successfully',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ),
      );
    } else {
      // Display a message to remind the user to select a size
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          content: Text(
            'Please select size!',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset(widget.product['imageUrl'] as String),
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
                    '\$${widget.product['price']}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['sizes'] as List<int>).length,
                      itemBuilder: (context, index) {
                        final size =
                            (widget.product['sizes'] as List<int>)[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                            child: Chip(
                              label: Text(
                                size.toString(),
                                style: TextStyle(
                                  color: selectedSize == size
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              backgroundColor: selectedSize == size
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  label: const Text(
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
