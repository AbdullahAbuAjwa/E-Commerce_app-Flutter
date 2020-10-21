import 'package:flutter/material.dart';
import 'package:flutter_app2/E-commerce%20app/Widgets/drawer.dart';
import 'package:flutter_app2/E-commerce%20app/model_and_provider/order.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: ShopDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchOrdersData(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot == null) {
              return Text('Error');
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) {
                  print(orderData.orders.length);
                  return ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (ctx, index) {
                        return OrderItemCard(orderData.orders[index]);
                      });
                },
              );
            }
          }
        },
      ),
    );
  }
}

class OrderItemCard extends StatefulWidget {
  final OrderItem order;

  OrderItemCard(this.order);

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(children: <Widget>[
        ListTile(
          title: Text('\$${widget.order.amount}'),
          subtitle: Text(
            DateFormat('dd/MM/yyyy hh:mm')
                .format(widget.order.dateTime.toDate()),
          ),
          trailing: IconButton(
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
        ),
        if (_expanded)
          Container(
            padding: EdgeInsets.all(8),
            height: 80,
            child: ListView(
              children: widget.order.products
                  .map(
                    (p) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          p.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${p.qty}x \$${p.price}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          )
      ]),
    );
  }
}
