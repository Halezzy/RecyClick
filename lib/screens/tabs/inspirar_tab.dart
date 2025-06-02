import 'package:flutter/material.dart';

class InspirarTab extends StatelessWidget {
  const InspirarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Ideias, dicas e projetos sustentáveis",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
