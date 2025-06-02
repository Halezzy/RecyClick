import 'package:flutter/material.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Feed de Publicações",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
