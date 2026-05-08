import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:provider/provider.dart';

const String _boxName = 'tarefasBox';
const String _chaveListaTarefas = 'lista';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(_boxName);

  runApp(
    ChangeNotifierProvider(
      create: (_) => TarefaProvider(),
      child: const MyApp(),
    ),
  );
}

class TarefaProvider extends ChangeNotifier {
  final List<String> _tarefas = [];

  List<String> get tarefas => List.unmodifiable(_tarefas);

  Box get _box => Hive.box(_boxName);

  TarefaProvider() {
    _carregarDoHive();
  }

  void _carregarDoHive() {
    final salvo = _box.get(_chaveListaTarefas);
    if (salvo != null) {
      _tarefas.addAll(List<String>.from(salvo as List));
    }
  }

  void _salvarNoHive() {
    _box.put(_chaveListaTarefas, List<String>.from(_tarefas));
  }

  void adicionarTarefa(String tarefa) {
    final texto = tarefa.trim();
    if (texto.isEmpty) return;
    _tarefas.add(texto);
    _salvarNoHive();
    notifyListeners();
  }

  void removerTarefa(int index) {
    _tarefas.removeAt(index);
    _salvarNoHive();
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atividade 3 – Tarefas Provider + Hive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const TarefasPage(),
    );
  }
}

class TarefasPage extends StatelessWidget {
  const TarefasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Consumer<TarefaProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: 'Nova tarefa',
                          hintText: 'Ex.: Estudar Flutter',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.task_alt),
                        ),
                        onSubmitted: (valor) {
                          provider.adicionarTarefa(valor);
                          controller.clear();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton.icon(
                      onPressed: () {
                        provider.adicionarTarefa(controller.text);
                        controller.clear();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Adicionar'),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${provider.tarefas.length} tarefa(s)',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),

              const Divider(height: 1),

              Expanded(
                child: provider.tarefas.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.inbox_outlined,
                                size: 64, color: Colors.grey),
                            SizedBox(height: 12),
                            Text(
                              'Nenhuma tarefa ainda.\nAdicione uma acima!',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: provider.tarefas.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1, indent: 16, endIndent: 16),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.teal.shade100,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(provider.tarefas[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  color: Colors.redAccent),
                              tooltip: 'Remover tarefa',
                              onPressed: () => provider.removerTarefa(index),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}