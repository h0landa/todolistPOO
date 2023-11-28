import 'package:flutter/material.dart';

Widget myTextField(
    String label, String placeHolder, TextEditingController controller) {
  return Container(
    child: Column(
      children: [
        SizedBox(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Roboto Condensed',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
              hintText: placeHolder,
              hintStyle: TextStyle(
                fontFamily: 'Roboto Condensed',
                fontSize: 16,
                color: Colors.grey[600],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              )),
        ),
      ],
    ),
  );
}
