import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../model/Item.dart';
import 'package:provider/provider.dart';
import '../provider/shoppingcart_provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Item Details"),
          getProducts(context),
        ],
      ),
    );
  }

  Widget getProducts(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    return products.isEmpty
      ? const Text('No Items to checkout!')
      : Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(products[index].name),
                      trailing: Text(products[index].price.toString()),
                    );
                  },
                )),
              const Divider(height: 4, color: Colors.black),
              showTotal(),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Payment Successful!"),
                    duration: const Duration(seconds: 1, milliseconds: 100),
                  ));
                  context.read<ShoppingCart>().removeAll();
                  Navigator.pushNamed(context, '/products');
                },
              child: const Text("Pay Now!")),
            ],
          ));
  }

  Widget showTotal() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
      return Text("Total Cost to Pay: ${cart.cartTotal}");
    });
  }

}