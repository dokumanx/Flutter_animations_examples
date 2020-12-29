import 'package:flutter/material.dart';
import 'package:flutter_animations/johannes_mike_examples/data.dart';
import 'package:flutter_animations/johannes_mike_examples/model/shopping_item.dart';
import 'package:flutter_animations/johannes_mike_examples/widget/shopping_item_widget.dart';

class AnimatedListExample extends StatefulWidget {
  @override
  _AnimatedListExampleState createState() => _AnimatedListExampleState();
}

class _AnimatedListExampleState extends State<AnimatedListExample> {
  List<ShoppingItem> _items = List<ShoppingItem>.from(Data.shoppingList);
  final key = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Animated List"),
        ),
        body: Column(
          children: [
            Expanded(
                child: AnimatedList(
              key: key,
              initialItemCount: _items.length,
              itemBuilder: (context, index, animation) {
                return buildItem(_items[index], index, animation);
              },
            )),
            Container(
              padding: EdgeInsets.all(16.0),
              child: buildInsertButton(),
            ),
          ],
        ));
  }

  Widget buildInsertButton() => RaisedButton(
      onPressed: () => insertItem(_items.length, _items.first),
      color: Colors.white,
      child: Text(
        "Insert item",
        style: TextStyle(fontSize: 20),
      ));

  Widget buildItem(ShoppingItem item, int index, Animation<double> animation) {
    return ShoppingItemWidget(
      animation: animation,
      item: item,
      onClicked: () => removeItem(index),
    );
  }

  void insertItem(int index, ShoppingItem item) {
    _items.insert(index, item);
    key.currentState.insertItem(index);
  }

  void removeItem(int index) {
    //remove normal list
    var item = _items.removeAt(index);
    //remove animatedList
    key.currentState.removeItem(
        index, (context, animation) => buildItem(item, index, animation));
  }
}
