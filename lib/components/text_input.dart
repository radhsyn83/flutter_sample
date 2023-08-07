import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final bool? obsecure;

  const TextInput({required this.label, this.obsecure = false, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      obscureText: obsecure!,
      decoration: InputDecoration(
        hintText: '',
        hintStyle: const TextStyle(height: 2, fontWeight: FontWeight.bold),
        labelText: label,
        labelStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.grey),
      ),
    );
  }
}
