import 'package:abdallatodoapp/cubits/navigation_bar_cubit.dart';
import 'package:flutter/material.dart';

import '../widgets/menulistitem.dart';

class Menuscreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder:(context,index)=> MenuListItem( model: NavigationBarCubit.get(context).tasks[index],),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 30),
          child: Divider(color: Colors.grey,),
        ),
        itemCount: NavigationBarCubit.get(context).tasks.length);
  }
}


