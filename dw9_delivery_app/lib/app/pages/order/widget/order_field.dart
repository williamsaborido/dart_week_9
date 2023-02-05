import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles_app.dart';

class OrderField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final String hint;

  final _defaultBorder = const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  );

  const OrderField({
    Key? key,
    required this.title,
    required this.controller,
    required this.validator,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: context.textStyle.textRegular.copyWith(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: hint,
              border: _defaultBorder,
              enabledBorder: _defaultBorder,
              focusedBorder: _defaultBorder,
            ),
          )
        ],
      ),
    );
  }
}
