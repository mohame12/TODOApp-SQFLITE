import 'package:abdallatodoapp/cubits/navigation_bar_cubit.dart';
import 'package:flutter/material.dart';

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    super.key, required this.model,
  });

  final Map model;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (d)
      {
        NavigationBarCubit.get(context).deleteData(id: model['id']);
      },
      direction: DismissDirection.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius:40,
              backgroundColor: Colors.black,
              child: Text(model['time'],style: const TextStyle(color: Colors.white),),),
            const SizedBox(width: 20,),
            Expanded(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(model['title'],style: const TextStyle(fontWeight: FontWeight.bold,),),
                      Text(model['date'],style: const TextStyle(color: Colors.grey),)
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: (){
                  NavigationBarCubit.get(context).updateStatus(status: 'done', id: model['id']);
                },
                icon: const Icon(Icons.check_box,color: Colors.green,)),
      
            IconButton(
                onPressed: (){
                  NavigationBarCubit.get(context).updateStatus(status: 'Archive', id: model['id']);
      
                },
                icon: const Icon(Icons.archive,color: Colors.black,)),
      
          ],
        ),
      ),
    );
  }
}