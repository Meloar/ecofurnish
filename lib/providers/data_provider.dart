import 'package:device_info_plus/device_info_plus.dart';
import 'package:ecofurnish/models/cart_item_data.dart';
import 'package:ecofurnish/models/item.dart';
import 'package:ecofurnish/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var formatter = NumberFormat.decimalPattern();
DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

class Data extends ChangeNotifier {
  final List<CartItemData> _userCart = [];

  List<CartItemData> getUserCart() {
    return _userCart;
  }

  void addItemToCart(CartItemData cartItem) {
    _userCart.add(cartItem);
    notifyListeners();
  }

  void removeItemFromCart(CartItemData cartItem) {
    _userCart.remove(cartItem);
    notifyListeners();
  }

  void removeAllItemFromCart() {
    _userCart.clear();
    notifyListeners();
  }

  void incrementQuantity(CartItemData cartItemData) {
    cartItemData.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(CartItemData cartItemData) {
    if (cartItemData.quantity > 1) {
      cartItemData.quantity--;
      notifyListeners();
    }
  }

  String getCartTotal() {
    int total = 0;
    for (final cartItem in _userCart) {
      total = total + cartItem.quantity * cartItem.item.price;
    }
    final formattedTotalPrice =
        '${formatter.format(total).replaceAll(',', '.')} Ft';
    return formattedTotalPrice;
  }

  int drawerIndex = 1;

  void homeDrawerScreen() {
    drawerIndex = 1;
  }

  void cartDrawerScreen() {
    drawerIndex = 2;
  }

  var _token = '';
  int errorCode = 0;

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> login(String enteredEmail, String enteredPassword) async {
    final loginUrl = Uri.https('x', 'y');
    //AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //print(androidInfo.model);
    //print(iosInfo.model);
    try {
      final loginResponse = await http.post(
        loginUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'email': enteredEmail,
            'password': enteredPassword,
            'osType': 'android',
            'deviceInfo': 'androidInfo.model',
          },
        ),
      );
      errorCode = loginResponse.statusCode;
      if (errorCode >= 400) {
        return;
      }

      final Map data = json.decode(loginResponse.body);

      if (data['status'] == 200) {
        _token = data['data']['token'];
        await storage.write(key: 'token', value: _token);
      }
    } catch (error) {
      errorCode = 400;
    }
  }

  String getToken() {
    return _token;
  }

  late User _user;

  User getUserData() {
    return _user;
  }

  Future<void> logOut() async {
    _token = '';
    await storage.delete(key: 'token');
  }

  final List<Item> _itemList = [];

  Future<void> loadItems() async {
    _itemList.clear();
    String memoryToken = await storage.read(key: 'token') ?? '';
    if (memoryToken == '') {
      memoryToken = _token;
    }

    final userUrl = Uri.https('x', 'y');
    final itemUrl = Uri.https('x', 'y');
    try {
      final userResponse = await http.get(
        userUrl,
        headers: {'authorization': 'Bearer $memoryToken'},
      );

      errorCode = userResponse.statusCode;
      if (errorCode >= 400) {
        return;
      }

      final itemResponse = await http.get(
        itemUrl,
        headers: {'authorization': 'Bearer $memoryToken}'},
      );

      errorCode = itemResponse.statusCode;
      if (errorCode >= 400) {
        return;
      }

      final Map userdata = json.decode(userResponse.body);
      _user = User(userdata['data']['id'], userdata['data']['name'],
          userdata['data']['email']);

      final Map itemdata = json.decode(itemResponse.body);
      for (var i = 0; i < itemdata.length; i++) {
        _itemList.add(
          Item(
              itemdata['data'][i]['id'],
              itemdata['data'][i]['name'],
              itemdata['data'][i]['description'],
              itemdata['data'][i]['picture'],
              itemdata['data'][i]['price']),
        );
      }
    } catch (error) {
      errorCode = 400;
    }
  }

  List<Item> getItemList() {
    return _itemList;
  }

  bool noItemInCart = false;

  Future<void> sendOrder() async {
    noItemInCart = false;
    if (_userCart.isEmpty) {
      noItemInCart = true;
      return;
    }
    String memoryToken = await storage.read(key: 'token') ?? '';
    if (memoryToken == '') {
      memoryToken = _token;
    }

    final List<Map> order = [];

    for (var x = 0; x < _userCart.length; x++) {
      var item = {
        'id': _userCart[x].item.id.toString(),
        'quantity': _userCart[x].quantity.toString(),
      };
      order.add(item);
    }

    final sendOrderUrl = Uri.https('x', 'y');

    try {
      final sendOrderResponse = await http.post(
        sendOrderUrl,
        headers: {'authorization': 'Bearer $memoryToken}'},
        body: json.encode(order),
      );

      errorCode = sendOrderResponse.statusCode;
      if (errorCode >= 400) {
        return;
      }
      final Map data = json.decode(sendOrderResponse.body);
      if (data['status'] == 200) {
        _userCart.clear();
        notifyListeners();
      }
    } catch (error) {
      errorCode = 400;
    }
  }
}
