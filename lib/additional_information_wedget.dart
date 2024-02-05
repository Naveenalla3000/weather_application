import 'package:flutter/material.dart';

class AdditionalInformationWeget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInformationWeget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 32,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            value,
          ),
        ],
      ),
    );
  }
}
