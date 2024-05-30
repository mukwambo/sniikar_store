import 'package:flutter/material.dart';
import 'package:sniikar_store/product_card.dart';
import 'package:sniikar_store/product_details_page.dart';
import 'global_variables.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> shoeBrandFilters = const [
    'All',
    'Nike',
    'Adidas',
    'Jordan',
    'Vans',
    'Converse'
  ];
  late String selectedShoeBrand;

  @override
  void initState() {
    super.initState();
    selectedShoeBrand = shoeBrandFilters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
    );

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Sniikar\nCollection",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              /* The expanded widget will tells the textField to take as much space as possible, this widget is more efficient than
                wrapping the textField with SizedBox. Sized box would lead to errors in varied screens.
                 */
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: shoeBrandFilters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final shoeBrandFilter = shoeBrandFilters[index];
                /* The chip widget will help create the oval filters, since it takes in a widget as an argument,
                      we pass in the text as the argument then pas the list os brand filters as the argument to the text.
                      */
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      /*
                        setState() helps rebuild the UI i.e. If we hadn't used the setState(), changing the brand
                        category say from 'All' to 'Nike', the changes would not have effected until you hot reload the App.
                        But with the help of setState(), the UI automatically rebuilds itself without having to  wait for hot reload
                        hence effecting the changes between categories upon click.
                         */
                      setState(() {
                        selectedShoeBrand = shoeBrandFilter;
                      });
                    },
                    child: Chip(
                      label: Text(shoeBrandFilter),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      backgroundColor: selectedShoeBrand == shoeBrandFilter
                          ? Theme.of(context).primaryColor
                          : const Color.fromRGBO(200, 200, 200, 0.2),
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: selectedShoeBrand == shoeBrandFilter
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(0, 0, 0, 1),
                      ),
                      side: const BorderSide(
                        color: Color.fromRGBO(
                          200,
                          200,
                          200,
                          0.2,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ProductDetails(product: product);
                    }));
                  },
                  child: ProductCard(
                    productName: product['title'] as String,
                    productPrice: product['price'] as double,
                    image: product['imageUrl'] as String,
                    cardBackgroundColor: index.isEven
                        ? const Color.fromRGBO(200, 200, 200, 0.2)
                        : const Color.fromRGBO(255, 255, 255, 1),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
