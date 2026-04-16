import 'package:flutter/material.dart';

class ConstraintsScreen extends StatelessWidget {
  const ConstraintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Constraints de Layout'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle('Regra: Constraints go down. Sizes go up. Parent sets position.'),
            const SizedBox(height: 16),

            // --- Exemplo 1: Widget ocupa tudo ---
            _ExampleCard(
              title: 'Exemplo 1: Container sem restrição',
              description:
                  'Um Container sem width/height preenche o espaço disponível passado pelo pai.',
              child: Container(
                color: Colors.blue[200],
                child: const Text('Sem size → preenche o pai'),
              ),
            ),

            // --- Exemplo 2: SizedBox com tamanho fixo ---
            _ExampleCard(
              title: 'Exemplo 2: SizedBox com tamanho fixo',
              description:
                  'SizedBox(width:100, height:50) força o filho a ter exatamente esse tamanho.',
              child: SizedBox(
                width: 100,
                height: 50,
                child: Container(
                  color: Colors.green[300],
                  child: const Center(child: Text('100×50')),
                ),
              ),
            ),

            // --- Exemplo 3: Row com Expanded ---
            _ExampleCard(
              title: 'Exemplo 3: Row + Expanded',
              description:
                  'Expanded distribui o espaço restante. O filho dentro deve aceitar constraints finitas.',
              child: Row(
                children: [
                  Container(width: 60, height: 40, color: Colors.orange[300],
                      child: const Center(child: Text('Fixo'))),
                  Expanded(
                    child: Container(height: 40, color: Colors.orange[100],
                        child: const Center(child: Text('Expanded'))),
                  ),
                ],
              ),
            ),

            // --- Exemplo 4: Column com shrinkWrap ---
            _ExampleCard(
              title: 'Exemplo 4: ListView shrinkWrap dentro de Column',
              description:
                  'shrinkWrap:true faz o ListView ter a altura do seu conteúdo, evitando erro de altura infinita.',
              child: Column(
                children: [
                  Container(
                    color: Colors.purple[100],
                    padding: const EdgeInsets.all(8),
                    child: const Text('Item fora da ListView'),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      ListTile(title: Text('ListView Item 1')),
                      ListTile(title: Text('ListView Item 2')),
                    ],
                  ),
                ],
              ),
            ),

            // --- Exemplo 5: LayoutBuilder ---
            _ExampleCard(
              title: 'Exemplo 5: LayoutBuilder mostrando constraints',
              description:
                  'LayoutBuilder expõe as constraints do pai para que o filho decida como se organizar.',
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    color: Colors.teal[100],
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'maxWidth: ${constraints.maxWidth.toStringAsFixed(1)}\n'
                      'maxHeight: ${constraints.maxHeight.toStringAsFixed(1)}\n'
                      'minWidth: ${constraints.minWidth.toStringAsFixed(1)}\n'
                      'minHeight: ${constraints.minHeight.toStringAsFixed(1)}',
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                  );
                },
              ),
            ),

            // --- Exemplo 6: MediaQuery ---
            _ExampleCard(
              title: 'Exemplo 6: MediaQuery com % da tela',
              description:
                  'MediaQuery.of(context).size retorna o tamanho TOTAL da tela.',
              child: Builder(
                builder: (context) {
                  final size = MediaQuery.of(context).size;
                  return Container(
                    width: size.width * 0.6,
                    height: 60,
                    color: Colors.red[200],
                    child: Center(
                      child: Text(
                        '60% da largura = ${(size.width * 0.6).toStringAsFixed(1)}px',
                      ),
                    ),
                  );
                },
              ),
            ),

            // --- Exemplo 7: Container vs SizedBox ---
            _ExampleCard(
              title: 'Exemplo 7: Container vs SizedBox',
              description:
                  'Container pode decorar (cor, borda), SizedBox é mais leve para só definir tamanho.',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Container(
                      width: 80, height: 50,
                      color: Colors.cyan[300],
                      child: const Center(child: Text('Container')),
                    ),
                    const SizedBox(height: 4),
                    const Text('Container', style: TextStyle(fontSize: 11)),
                  ]),
                  Column(children: [
                    SizedBox(
                      width: 80, height: 50,
                      child: ColoredBox(
                        color: Colors.amber[300]!,
                        child: const Center(child: Text('SizedBox')),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text('SizedBox', style: TextStyle(fontSize: 11)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------- Widgets auxiliares --------

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.indigo[200]!),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.indigo[800],
          fontSize: 13,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const _ExampleCard({
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text(description,
                style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}