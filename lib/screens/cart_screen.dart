import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:ecofurnish/res/colors/app_colors.dart';
import 'package:ecofurnish/widgets/drawer.dart';
import 'package:ecofurnish/providers/data_provider.dart';
import 'package:ecofurnish/models/cart_item_data.dart';
import 'package:ecofurnish/widgets/cart_item.dart';

var formatter = NumberFormat.decimalPattern();

@RoutePage()
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() {
    return _CartScreenState();
  }
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Kosár'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ],
        ),
        drawer: const SideDrawer(),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: value.getUserCart().length,
                    itemBuilder: (context, index) {
                      CartItemData cartItemData = value.getUserCart()[index];

                      return CartItem(
                        cartItemData: cartItemData,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Kosár összesen: ${value.getCartTotal()}',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                      color: AppColors().textColorFirst,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors().buttonColorFirst,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
                      fixedSize: const Size(320, 48)),
                  onPressed: () async {
                    await value.sendOrder();
                    if (context.mounted) {
                      if (value.errorCode >= 400 || value.noItemInCart) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Nem sikerült elküldeni a megrendelést!'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sikeres rendelés!'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Megrendelés',
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
