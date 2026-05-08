import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('configBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atividade 1 – Hive Modo',
      debugShowCheckedModeBanner: false,
      home: const ModoPage(),
    );
  }
}

class ModoPage extends StatefulWidget {
  const ModoPage({super.key});

  @override
  State<ModoPage> createState() => _ModoPageState();
}

class _ModoPageState extends State<ModoPage> {
  static const String _chaveRelax = 'isRelax';

  late final Box _box;

  bool _isRelax = true;

  @override
  void initState() {
    super.initState();
    _box = Hive.box('configBox');

    _isRelax = _box.get(_chaveRelax, defaultValue: true) as bool;
  }

  void _alternarModo() {
    setState(() {
      _isRelax = !_isRelax;
    });
    _box.put(_chaveRelax, _isRelax);
  }

  @override
  Widget build(BuildContext context) {
    final Color corFundo = _isRelax ? Colors.blue.shade200 : Colors.green.shade300;
    final String texto = _isRelax ? 'Modo Relax 😌' : 'Modo Focado 🎯';
    final String labelBotao = _isRelax ? 'Ativar Modo Focado' : 'Ativar Modo Relax';

    return Scaffold(
      backgroundColor: corFundo,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              texto,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '(estado salvo no Hive)',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _alternarModo,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: Colors.white,
                foregroundColor: corFundo,
              ),
              child: Text(
                labelBotao,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}