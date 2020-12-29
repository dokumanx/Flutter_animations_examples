import 'package:flutter/material.dart';
import 'package:flutter_animations/johannes_mike_examples/model/shopping_item.dart';

class ShoppingItemWidget extends StatelessWidget {
  final ShoppingItem item;
  final Animation animation;
  final VoidCallback onClicked;

  const ShoppingItemWidget({
    Key key,
    this.item,
    this.animation,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizeTransition(
        sizeFactor: animation,
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15), offset: Offset(0.5, 0.5))
          ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 12),
            leading: CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(item.urlImage),
            ),
            title: Text(
              item.title,
              style: TextStyle(fontSize: 20),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              onPressed: onClicked,
            ),
          ),
        ),
      );
}
