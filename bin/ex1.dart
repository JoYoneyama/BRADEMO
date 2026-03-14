void main() {
  var equipamento = "Impressora 3D";

  String local = "Lab de Protótipos";

  dynamic patrimonio = 12345;

  patrimonio = "12345-A";

  print("Equipamento: $equipamento");
  print("Local: $local");
  print("Patrimônio: $patrimonio");

  print("equipamento é String? ${equipamento is String}");
  print("local é String? ${local is String}");
  print("patrimonio é int? ${patrimonio is int}");
  print("patrimonio é String? ${patrimonio is String}");

  /*
  O Dart permite mudar o tipo de 'patrimonio' porque ele foi declarado como
  dynamic. Variáveis dynamic podem receber valores de qualquer.

  Já 'local' foi declarado como String. Isso significa que
  seu tipo é fixo e o compilador não permite atribuir valores de outro tipo
  (como int ou double) a essa variável.
  */
}