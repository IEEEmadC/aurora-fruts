import 'package:aurora_fruts/models/cart.dart';
import 'package:aurora_fruts/models/product.dart';
import 'package:flutter/material.dart';
import 'package:aurora_fruts/data/example/cart_example.dart' as carex;

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final Cart cartExample = carex.carrito;

  double total;
  double _getPrice(Product product, int quantity) {
    double _discount =
        product.discount != null ? product.discount : product.price;
    double result = quantity * _discount;
    return result;
  }

  double _getTotal(List<Product> products, List<int> quantity) {
    double total = 0;
    for (int i = 0; i < products.length; i++) {
      double _price = products[i].discount != null
          ? products[i].discount
          : products[i].price;
      total = total + (_price * quantity[i]);
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    total = 0;
  }

  @override
  Widget build(BuildContext context) {
    List<Product> _products = cartExample.productList.keys.toList();
    List<int> _cantidades = cartExample.productList.values.toList();

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 24.0,
          left: 8.0,
          bottom: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                        text: 'Mi\n',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: 'Orden',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w300))
                  ]),
            ),
            SizedBox(height: 32.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: carex.carrito.productList.length,
              itemBuilder: (context, item) {
                return ItemCart(
                  imageLink: _products[item].images[0],
                  name: _products[item].name,
                  quantity: _cantidades[item],
                  price: _getPrice(_products[item], _cantidades[item]),
                );
              },
            ),
            SizedBox(
              height: 32.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total:',
                    style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "\$ ${_getTotal(_products, _cantidades).toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemCart extends StatelessWidget {
  final int quantity;
  final String imageLink;
  final String name;
  final double price;
  ItemCart({this.name, this.quantity, this.price,this.imageLink});

  Widget _imageProduct() {
    return ClipRRect(
      //TODO: add the image product
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        height: 60.0,
        width: 80.0,
        color: Colors.blue,
        child: Image.network(imageLink,fit: BoxFit.cover,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          _imageProduct(),
          SizedBox(width: 16.0),
          Text(quantity.toString(),
              style: Theme.of(context).textTheme.display4),
          Text("\t\tx\t\t", style: Theme.of(context).textTheme.display4),
          Expanded(
            child: SizedBox(
                width: 130.0,
                child: Text('${name[0].toUpperCase()}${name.substring(1)}',
                    style: Theme.of(context).textTheme.display4)),
          ),
          Text(
            "\$ ${price.toStringAsFixed(2)}",
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          )
        ],
      ),
    );
  }
}