void main() {
  var laptop1 = Laptop(1, "Dell XPS", 16, 3.2);
  var laptop2 = Laptop(2, "MacBook Pro", 32, 3.5);
  var laptop3 = Laptop(3, "Lenovo ThinkPad", 8, 2.8);

  laptop1.mostrarDetalhes();
  laptop2.mostrarDetalhes();
  laptop3.mostrarDetalhes();
}

class Laptop {
  int id;
  String nome;
  int ram;
  double clockCpu;

  Laptop(this.id, this.nome, this.ram, this.clockCpu);

   Laptop.internet(this.id)
      : nome = "Laptop Básico",
        ram = 4,
        clockCpu = 2.0;

  Laptop.escritorio(this.id)
      : nome = "Laptop Escritório",
        ram = 8,
        clockCpu = 2.5;

  Laptop.programacao(this.id)
      : nome = "Laptop Programação",
        ram = 16,
        clockCpu = 3.2;

  void mostrarDetalhes() {
    print("ID: $id");
    print("Nome: $nome");
    print("RAM: ${ram}GB");
    print("Clock CPU: ${clockCpu}GHz");
    print("-------------------");
  }
}