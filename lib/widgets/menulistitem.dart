import 'package:flutter/material.dart';

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    super.key, required this.model,
  });

  final Map model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          CircleAvatar(
            radius:40,
            backgroundColor: Colors.black,
            child: Text(model['time'],style: TextStyle(color: Colors.white),),),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(model['title'],style: TextStyle(fontWeight: FontWeight.bold,),),
              Text(model['date'],style: TextStyle(color: Colors.grey),)
            ],
          )
        ],
      ),
    );
  }
}