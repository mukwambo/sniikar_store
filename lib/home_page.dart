import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    return Scaffold(
      // The safe area  tells the column to move below the notch
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Sniikar\nCollection",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ),
                /* The expanded widget will tells the textField to take as much space as possible, this widget is more efficient than
                wrapping the textField with SizedBox. Sized box would lead to errors in varied screens.
                 */
                Expanded(
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
          ],
        ),
      ),
    );
  }
}
