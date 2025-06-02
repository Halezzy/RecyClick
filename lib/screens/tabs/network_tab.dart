import 'package:flutter/material.dart';

class NetworkTab extends StatelessWidget {
  const NetworkTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Conecte-se com outros recicladores",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
