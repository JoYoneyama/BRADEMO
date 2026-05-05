Future<String> buscarPedidoUsuario() async {
  await Future.delayed(const Duration(seconds: 2));
  throw Exception('Usuário não encontrado no sistema.');
}

Future<String> criarMensagemPedidoSegura() async {
  try {
    final pedido = await buscarPedidoUsuario();
    return 'Seu pedido é: $pedido';
  } catch (e) {
    return 'Erro ao buscar pedido: $e';
  }
}

Future<String> buscarComRetry(int tentativas) async {
  for (int i = 1; i <= tentativas; i++) {
    try {
      print('Tentativa $i...');
      await Future.delayed(const Duration(seconds: 1));
      if (i < tentativas) {
        throw Exception('Falha na tentativa $i');
      }
      return 'Pedido obtido na tentativa $i!';
    } catch (e) {
      print('  Erro: $e');
      if (i == tentativas) rethrow;
    }
  }
  return 'Não deveria chegar aqui';
}

Future<void> exemploOnError() async {
  final resultado = await buscarPedidoUsuario()
      .onError((error, stackTrace) => 'Valor padrão após erro: $error');
  print(resultado);
}

Future<void> main() async {
  print('=== ATIVIDADE 2: Tratamento de Erros ===\n');

  print('-- try-catch --');
  final msg = await criarMensagemPedidoSegura();
  print(msg);

  print('\n-- Retry automático (3 tentativas) --');
  try {
    final resultado = await buscarComRetry(3);
    print(resultado);
  } catch (e) {
    print('Todas as tentativas falharam: $e');
  }

  print('\n-- onError --');
  await exemploOnError();
}