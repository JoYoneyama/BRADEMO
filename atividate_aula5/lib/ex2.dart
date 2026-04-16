import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({super.key});

  static const List<String> _languages = ['Dart', 'JavaScript', 'PHP', 'C++'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Layouts'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Portrait (largura < 600): coluna única
          if (constraints.maxWidth < 600) {
            return _buildPortraitLayout();
          }
          // Landscape (largura >= 600): duas colunas lado a lado
          return _buildLandscapeLayout();
        },
      ),
    );
  }

  // ---------- PORTRAIT ----------
  Widget _buildPortraitLayout() {
    return Column(
      children: [
        _buildLeftPanel(isPortrait: true),
        const Divider(height: 1),
        Expanded(child: _buildLanguageList()),
      ],
    );
  }

  // ---------- LANDSCAPE ----------
  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        // Painel esquerdo fixo
        SizedBox(width: 300, child: _buildLeftPanel(isPortrait: false)),
        const VerticalDivider(width: 1),
        // Lista ocupa o restante
        Expanded(child: _buildLanguageList()),
      ],
    );
  }

  // ---------- PAINEL ESQUERDO (título + botões) ----------
  Widget _buildLeftPanel({required bool isPortrait}) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Cheetah Coding',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white54),
              ),
              onPressed: () {},
              child: const Text('BUTTON 1'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white54),
              ),
              onPressed: () {},
              child: const Text('BUTTON 2'),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- LISTA DE LINGUAGENS ----------
  Widget _buildLanguageList() {
    return Container(
      color: Colors.black87,
      child: ListView.separated(
        itemCount: _languages.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: Colors.white24),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _languages[index],
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}