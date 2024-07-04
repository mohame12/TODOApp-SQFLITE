import 'package:abdallatodoapp/cubits/navigation_bar_cubit.dart';
import 'package:abdallatodoapp/cubits/navigation_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/menulistitem.dart';

class Menuscreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBarCubit, NavigationBarState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return ListView.separated(itemBuilder:(context,index)=> MenuListItem( model: NavigationBarCubit.get(context).tasks[index],),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 30),
          child: Divider(color: Colors.grey,),
        ),
        itemCount: NavigationBarCubit.get(context).tasks.length);
  },
);
  }
}


