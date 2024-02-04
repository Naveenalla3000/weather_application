import 'package:flutter/material.dart';

class AdditionalInformationWeget extends StatelessWidget {
  const AdditionalInformationWeget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: <Widget>[
          Text(
            "04:00",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Icon(
            Icons.water_drop,
            size: 32,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "320.12",
          ),
        ],
      ),
    );
  }
}
