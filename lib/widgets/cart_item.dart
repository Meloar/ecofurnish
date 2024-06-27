import 'package:auto_route/auto_route.dart';
import 'package:ecofurnish/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecofurnish/providers/data_provider.dart';
import 'package:ecofurnish/models/cart_item_data.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.cartItemData,
  });

  final CartItemData cartItemData;

  @override
  State<CartItem> createState() {
    return _CartItemState();
  }
}

class _CartItemState extends State<CartItem> {
  void removeItemFromCart() {
    Provider.of<Data>(context, listen: false).removeItemFromCart(
      widget.cartItemData,
    );
  }

  void incrementQuantity() {
    Provider.of<Data>(context, listen: false).incrementQuantity(
      widget.cartItemData,
    );
  }

  void decreaseQuantity() {
    Provider.of<Data>(context, listen: false).decreaseQuantity(
      widget.cartItemData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(
          ProductRoute(item: widget.cartItemData.item),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: 120,
        padding: const EdgeInsets.only(
          left: 17,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.cartItemData.item.picture,
                width: 152,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 11,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.cartItemData.item.name),
                Text(widget.cartItemData.item.getFormattedPrice()),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: decreaseQuantity,
                            icon: const Icon(Icons.remove),
                          ),
                          Text('${widget.cartItemData.quantity}'),
                          IconButton(
                            onPressed: incrementQuantity,
                            icon: const Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    IconButton(
                      onPressed: removeItemFromCart,
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
