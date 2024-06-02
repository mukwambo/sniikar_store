import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sniikar_store/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    /*
    In order to continuously listen to something in relation to a provider,
    we have to do it in the build function otherwise listen will be set to false
    and we won't be able to listen to anything.
    */
    final cart = context.watch<CartProvider>().cart;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart'),
      ),
      body: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final cartItem = cart[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                radius: 30,
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Center(
                          child: Text('Remove from Cart',
                              style: Theme.of(context).textTheme.titleMedium),
                        ),
                        content: Text(
                            'Are you sure you want to remove ${cartItem['title']} from cart?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // The line below dismisses the dialog when the No option is clicked
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              /* Here we call the delete product method that we had defined in the
                              CartProvider class.
                              */
                              context
                                  .read<CartProvider>()
                                  .removeProduct(cartItem);
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
              title: Text(
                cartItem['title'].toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text('Size: ${cartItem['size']}'),
            );
          }),
    );
  }
}
