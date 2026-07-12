import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key, required this.title, this.description, required this.icon});

  final String title;
  final String? description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: description == null ? null : Text(description!),
      leading: Icon(icon),
    );
  }
}