import 'package:auto_route/auto_route.dart';
import 'package:ecofurnish/providers/data_provider.dart';
import 'package:ecofurnish/models/cart_item_data.dart';
import 'package:ecofurnish/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ecofurnish/models/item.dart';
import 'package:ecofurnish/res/colors/app_colors.dart';
import 'package:ecofurnish/widgets/drawer.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.item});

  final Item item;

  @override
  State<ProductScreen> createState() {
    return _ProductScreenState();
  }
}

class _ProductScreenState extends State<ProductScreen> {
  void addItemToCart(Item item, int quantity) {
    Provider.of<Data>(context, listen: false).addItemToCart(
      CartItemData(item, quantity),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hozzáadva a kocsihoz'),
      ),
    );
  }

  int _quantity = 1;

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrease() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.item.name),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                value.cartDrawerScreen();
                AutoRouter.of(context).replaceAll([
                  const CartRoute(),
                ]);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ],
        ),
        drawer: const SideDrawer(),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 30,
          ),
          child: Container(
            width: 320,
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.item.picture,
                    width: 320,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 187,
                          child: Text(
                            widget.item.name,
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                                color: AppColors().textColorFirst,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          widget.item.getFormattedPrice(),
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors().textColorFirst,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 123,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _decrease,
                            icon: const Icon(Icons.remove),
                          ),
                          Text('$_quantity'),
                          IconButton(
                            onPressed: _increment,
                            icon: const Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.item.description,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors().textColorSecond,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors().buttonColorFirst,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
                      fixedSize: const Size(320, 48)),
                  onPressed: () => addItemToCart(widget.item, _quantity),
                  child: const Text(
                    'Kosárba',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
