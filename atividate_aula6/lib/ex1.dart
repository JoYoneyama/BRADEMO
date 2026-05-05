Future<String> buscarPedidoUsuario() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Large Latte';
}

Future<String> buscarDescricaoItem(String item) async {
  await Future.delayed(const Duration(seconds: 1));
  return '$item: café expresso com leite vaporizado';
}

Future<String> criarMensagemPedido() async {
  final pedido = await buscarPedidoUsuario();
  final descricao = await buscarDescricaoItem(pedido);
  return 'Seu pedido: $pedido\nDescrição: $descricao';
}

Future<void> main() async {
  print('=== ATIVIDADE 1: async e await ===\n');

  print('Buscando pedido de usuário...');
  final mensagem = await criarMensagemPedido();
  print(mensagem);

  print('\n-- Pedidos em paralelo com Future.wait --');
  final resultados = await Future.wait([
    buscarPedidoUsuario(),
    buscarPedidoUsuario(),
    buscarPedidoUsuario(),
  ]);
  for (int i = 0; i < resultados.length; i++) {
    print('Cliente ${i + 1}: ${resultados[i]}');
  }
}
