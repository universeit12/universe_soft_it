import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintext;
  final TextInputType? keyboardtype;
  final bool? readonly;
  final Color? color;
  final double focusborderwidth;
  final double enableborderwidth;

  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final int maxline;
  final void Function(String?)? onchanged;
  final FormFieldValidator<String>? validator;

  const CustomPasswordFormField ({
    super.key,
    required this.controller,
    required this.hintext,
    this.keyboardtype,
    this.readonly = false,
    this.focusborderwidth = 2,
    this.enableborderwidth = 1,
    this.maxline = 1,
    this.color = Colors.blue,

    this.suffixIcon,
    this.onTap,
    this.onchanged, this.validator,
  });


  @override
  State<CustomPasswordFormField> createState() => _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  @override
  Widget build(BuildContext context) {
    bool isvisibility = true;
    return Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color:Colors.white,
        ),
        padding: const EdgeInsets.only(left: 10),
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardtype,
          obscureText: isvisibility,

          decoration:  InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintext,

            suffixIcon:IconButton(
                onPressed: () {
                  setState(() {
                    isvisibility = !isvisibility;
                  });
                },
                icon: Icon(
                  isvisibility ? Icons.visibility_off : Icons.visibility,
                  color: widget.color,
                  size: 20,
                )),



          ),));
  }
}
