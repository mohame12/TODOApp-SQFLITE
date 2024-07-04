import 'package:abdallatodoapp/cubits/navigation_bar_cubit.dart';
import 'package:abdallatodoapp/cubits/navigation_bar_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/menulistitem.dart';

class Donescreen extends StatelessWidget {
  const Donescreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBarCubit, NavigationBarState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: NavigationBarCubit.get(context).donetasks.isNotEmpty,
          builder: (BuildContext context)=>ListView.separated(itemBuilder:(context,index)=> MenuListItem( model: NavigationBarCubit.get(context).donetasks[index],),
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 30),
                child: Divider(color: Colors.grey,),
              ),
              itemCount: NavigationBarCubit.get(context).donetasks.length),
          fallback: (BuildContext context)=>const Center(child: Text('Please Add Some Tasks...')),

        );
      },
    );
  }
}


