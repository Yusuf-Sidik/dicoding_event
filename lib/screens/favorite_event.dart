import 'package:flutter/material.dart';

class FavoriteEvent extends StatelessWidget {
  const FavoriteEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite, size: 50, color: Colors.red),
          const SizedBox(height: 20),
          Text(
            'Favorite Events',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          const Text('Daftar event favorit Anda'),
        ],
      ),
    );
  }
}
