import 'package:abdallatodoapp/consts.dart';
import 'package:flutter/material.dart';

import '../widgets/menulistitem.dart';

class Menuscreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder:(context,index)=> MenuListItem( model: tasks[index],),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 30),
          child: Divider(color: Colors.grey,),
        ),
        itemCount: tasks.length);
  }
}


