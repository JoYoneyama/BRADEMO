import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  bool completed;

  Task({required this.id, required this.title, this.completed = false});
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool _showCompleted = false;

  final List<Task> _tasks = List.generate(
    5,
    (i) => Task(
      id: 'task_$i',
      title:
          'Task 2022-07-09\n18:08:3${i + 1}.${(100000 + i * 123456) % 999999}',
    ),
  );

  List<Task> get _visibleTasks =>
      _showCompleted ? _tasks : _tasks.where((t) => !t.completed).toList();

  int get _uncompletedCount => _tasks.where((t) => !t.completed).length;

  void _showInfoDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Sobre o App'),
          content: const SingleChildScrollView(
            child: Text('Você está no App de Notas de Tarefas'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _addTask() {
    final now = DateTime.now();
    setState(() {
      _tasks.add(Task(
        id: 'task_${_tasks.length}',
        title:
            'Task ${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}\n'
            '${now.hour.toString().padLeft(2, '0')}:'
            '${now.minute.toString().padLeft(2, '0')}:'
            '${now.second.toString().padLeft(2, '0')}.'
            '${now.millisecond.toString().padLeft(6, '0')}',
      ));
    });
  }

  void _deleteTask(String id) {
    setState(() {
      _tasks.removeWhere((t) => t.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () =>
                    setState(() => _showCompleted = !_showCompleted),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  textStyle: const TextStyle(fontSize: 13),
                ),
                child: Text(
                    _showCompleted ? 'View Uncompleted Tasks' : 'View Completed Tasks'),
              ),
            ),
          ),

          // Contador de tarefas não concluídas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'You have $_uncompletedCount uncompleted tasks',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Lista de tarefas
          Expanded(
            child: _visibleTasks.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma tarefa para exibir.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _visibleTasks.length,
                    itemBuilder: (context, index) {
                      final task = _visibleTasks[index];
                      return _buildTaskCard(task);
                    },
                  ),
          ),
        ],
      ),

      // FAB abre AlertDialog
      floatingActionButton: FloatingActionButton(
        onPressed: _showInfoDialog,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTaskCard(Task task) {
    final isYellow = _tasks.indexOf(task).isEven;
    return Card(
      color: isYellow ? Colors.amber[200] : Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 13,
            decoration:
                task.completed ? TextDecoration.lineThrough : TextDecoration.none,
            color: task.completed ? Colors.grey : Colors.black87,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: task.completed,
              onChanged: (value) {
                setState(() => task.completed = value ?? false);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              iconSize: 20,
              onPressed: () => _deleteTask(task.id),
              tooltip: 'Remover tarefa',
            ),
          ],
        ),
        onTap: () => setState(() => task.completed = !task.completed),
      ),
    );
  }
}