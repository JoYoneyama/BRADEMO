import 'dart:io';

class House {
  int id;
  String name;
  double price;

  House(this.id, this.name, this.price);
}

void main() {
  List<House> casas = [];

  for (int i = 0; i < 3; i++) {
    print("Cadastro da casa ${i + 1}");

    stdout.write("Digite o id: ");
    int id = int.parse(stdin.readLineSync()!);

    stdout.write("Digite o nome: ");
    String name = stdin.readLineSync()!;

    stdout.write("Digite o preço: ");
    double price = double.parse(stdin.readLineSync()!);

    var casa = House(id, name, price);

    casas.add(casa);
    print("");
  }

  for (var casa in casas) {
    casa..name = "${casa.name} (Cadastrada)";
  }

  print("Casas cadastradas:");

  for (var casa in casas) {
    print("ID: ${casa.id}");
    print("Nome: ${casa.name}");
    print("Preço: ${casa.price}");
    print("---------------------");
  }
}