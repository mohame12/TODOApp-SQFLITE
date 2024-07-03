import 'package:flutter/material.dart';

class CustomTFF extends StatelessWidget {
  CustomTFF({
    super.key,
    required this.textInputType,
    required this.textEditingController,
    this.hint,
    required this.lable,
    this.onChange,
    this.onSupmitted,
    required this.isScure,
    this.prefix,
    this.susfix,
    this.susFun,
    this.ontap
  });


  final TextEditingController textEditingController;
  final TextInputType textInputType;
  var onChange;
  var onSupmitted;
  String? hint;
  final String lable;
  final bool isScure;
  IconData? susfix;
  IconData ?prefix;
  var ontap;
  var susFun;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty)
        {
          return 'Required Feild...';
        }
      },
      onTap: ontap,
      obscureText:isScure ,
      controller:textEditingController ,
      keyboardType: TextInputType.emailAddress,
      onFieldSubmitted:onSupmitted ,
      onChanged: onChange,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          suffixIcon:IconButton(icon: Icon(susfix), onPressed:susFun ,),
          prefixIcon:Icon(prefix) ,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.black45),
          labelText: lable,
          labelStyle: TextStyle(color: Colors.black45),

          enabled: true,
          enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ) ,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black)
          )
      ),
    );
  }
}