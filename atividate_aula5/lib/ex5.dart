import 'package:flutter/material.dart';

class BottomBarFabScreen extends StatefulWidget {
  const BottomBarFabScreen({super.key});

  @override
  State<BottomBarFabScreen> createState() => _BottomBarFabScreenState();
}

class _BottomBarFabScreenState extends State<BottomBarFabScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0;
  bool _fabOpen = false;

  late final AnimationController _animController;
  late final Animation<double> _expandAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _toggleFab() {
    setState(() {
      _fabOpen = !_fabOpen;
      if (_fabOpen) {
        _animController.forward();
      } else {
        _animController.reverse();
      }
    });
  }

  void _closeFab() {
    if (_fabOpen) {
      setState(() {
        _fabOpen = false;
        _animController.reverse();
      });
    }
  }

  static const List<_SpeedDialItem> _dialItems = [
    _SpeedDialItem(icon: Icons.call, label: 'Ligar', color: Colors.green),
    _SpeedDialItem(icon: Icons.email, label: 'E-mail', color: Colors.blue),
    _SpeedDialItem(icon: Icons.camera, label: 'Câmera', color: Colors.orange),
  ];

  static const List<String> _tabTitles = ['This', 'Is', 'A', 'Bottom', 'Bar'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeFab,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BottomAppBar with FAB'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            Center(
              child: Text(
                'TAB: ${_selectedTab + 1}',
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),

            if (_fabOpen)
              Positioned(
                bottom: 80,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _dialItems.asMap().entries.map((entry) {
                    final delay = entry.key * 0.15;
                    return FadeTransition(
                      opacity: Tween<double>(begin: 0, end: 1).animate(
                        CurvedAnimation(
                          parent: _animController,
                          curve: Interval(delay, delay + 0.5,
                              curve: Curves.easeOut),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _SpeedDialButton(item: entry.value, onTap: () {
                          _closeFab();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${entry.value.label} selecionado'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }),
                      ),
                    );
                  }).toList().reversed.toList(),
                ),
              ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: _toggleFab,
          backgroundColor: Colors.blue,
          child: AnimatedRotation(
            turns: _fabOpen ? 0.125 : 0, // 45° quando aberto
            duration: const Duration(milliseconds: 250),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...[0, 1].map((i) => _BottomItem(
                    icon: _tabIcon(i),
                    label: _tabTitles[i],
                    selected: _selectedTab == i,
                    onTap: () => setState(() {
                      _selectedTab = i;
                      _closeFab();
                    }),
                  )),
              const SizedBox(width: 56),
              ...[3, 4].map((i) => _BottomItem(
                    icon: _tabIcon(i),
                    label: _tabTitles[i],
                    selected: _selectedTab == i,
                    onTap: () => setState(() {
                      _selectedTab = i;
                      _closeFab();
                    }),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  IconData _tabIcon(int index) {
    const icons = [
      Icons.menu,
      Icons.favorite,
      Icons.grid_on,
      Icons.notifications,
    ];
    return icons[index % icons.length];
  }
}



class _SpeedDialItem {
  final IconData icon;
  final String label;
  final Color color;

  const _SpeedDialItem(
      {required this.icon, required this.label, required this.color});
}

class _SpeedDialButton extends StatelessWidget {
  final _SpeedDialItem item;
  final VoidCallback onTap;

  const _SpeedDialButton({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          child: Text(item.label, style: const TextStyle(fontSize: 13)),
        ),
        const SizedBox(width: 8),
        FloatingActionButton.small(
          heroTag: item.label,
          backgroundColor: item.color,
          onPressed: onTap,
          child: Icon(item.icon, color: Colors.white),
        ),
      ],
    );
  }
}

class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BottomItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.blue : Colors.grey;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          Text(label, style: TextStyle(fontSize: 10, color: color)),
        ],
      ),
    );
  }
}