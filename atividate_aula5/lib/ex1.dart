import 'package:flutter/material.dart';

class GridItem {
  final String imageUrl;
  final String title;
  final String subtitle;

  const GridItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });
}

class GridViewScreen extends StatelessWidget {
  const GridViewScreen({super.key});

  static const List<GridItem> _items = [
    GridItem(
      imageUrl: 'https://picsum.photos/seed/market1/400/300',
      title: 'Chennai',
      subtitle: 'Flower Market',
    ),
    GridItem(
      imageUrl: 'https://picsum.photos/seed/bronze/400/300',
      title: 'Tanjore',
      subtitle: 'Bronze Works',
    ),
    GridItem(
      imageUrl: 'https://picsum.photos/seed/tanjore1/400/300',
      title: 'Tanjore',
      subtitle: 'Market',
    ),
    GridItem(
      imageUrl: 'https://picsum.photos/seed/temple1/400/300',
      title: 'Tanjore',
      subtitle: 'Thanjavur Temple',
    ),
    GridItem(
      imageUrl: 'https://picsum.photos/seed/temple2/400/300',
      title: 'Tanjore',
      subtitle: 'Thanjavur Temple',
    ),
    GridItem(
      imageUrl: 'https://picsum.photos/seed/saltfarm/400/300',
      title: 'Pondicherry',
      subtitle: 'Salt Farm',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 1 - GridView'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.0,
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return _buildGridCard(item);
        },
      ),
    );
  }

  Widget _buildGridCard(GridItem item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Imagem de fundo
          Image.network(
            item.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[400],
              child: const Icon(Icons.image_not_supported, size: 48),
            ),
          ),
          // Gradiente + legenda na parte inferior
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.75),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}