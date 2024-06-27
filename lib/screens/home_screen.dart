import 'package:auto_route/auto_route.dart';
import 'package:ecofurnish/providers/data_provider.dart';
import 'package:ecofurnish/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

import 'package:ecofurnish/res/colors/app_colors.dart';
import 'package:ecofurnish/widgets/grid_item.dart';
import 'package:ecofurnish/widgets/drawer.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late Future futureData;

  @override
  void initState() {
    super.initState();
    futureData = loadItems();
  }

  Future<void> loadItems() async {
    await Provider.of<Data>(context, listen: false).loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, value, child) => FutureBuilder(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return (value.errorCode >= 400)
                ? const Scaffold(
                    body: Center(
                      child: Text(
                        'Nem állnak rendelkezésre adatok, kérlek próbáld meg később!',
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Scaffold(
                      appBar: AppBar(
                        title: const Text('Home'),
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
                      body: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 319,
                              child: TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(Icons.search),
                                  prefixIconColor: AppColors().buttonColorFirst,
                                  hintText: 'Keresés',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColors().textFieldColor,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GridView.builder(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 30,
                                  bottom: 10,
                                ),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemBuilder: (context, index) => GridItem(
                                  item: value.getItemList()[index],
                                ),
                                itemCount: value.getItemList().length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          }
        },
      ),
    );
  }
}
