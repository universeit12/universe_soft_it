import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final String hintext;
  final TextInputType? keyboardtype;
  final bool? readonly;
  final Color? color,containerColor,textColor;
  final double focusborderwidth;
  final double enableborderwidth;

  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final VoidCallback? onTap;
  final int maxline;
  final void Function(String?)? onchanged;
  final FormFieldValidator<String>? validator;
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintext,
    this.keyboardtype,
    this.readonly = false,
    this.focusborderwidth = 2,
    this.enableborderwidth = 1,
    this.maxline = 1,
    this.color = Colors.blue,

    this.prefixIcon,
    this.onTap,
    this.onchanged,
    this.validator, this.sufixIcon, this.containerColor=Colors.white, this.textColor=Colors.black38
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        decoration:  BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color:containerColor,
        ),
        padding: const EdgeInsets.only(left: 10),
        child: TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardtype,

          decoration:  InputDecoration(
            border: InputBorder.none,
            hintText: hintext,
            hintStyle: TextStyle(fontSize: 12,color:textColor ,fontFamily: "FontMain4"),

            suffixIcon: sufixIcon,

          ),));
  }
}
