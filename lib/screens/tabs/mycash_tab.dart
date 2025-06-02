import 'package:flutter/material.dart';

class MyCashTab extends StatelessWidget {
  const MyCashTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Pontos de coleta que pagam",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
