import 'ex3.dart';

void main() {
  var laptopInternet = Laptop.internet(1);
  var laptopEscritorio = Laptop.escritorio(2);
  var laptopProgramacao = Laptop.programacao(3);

  laptopInternet.mostrarDetalhes();
  laptopEscritorio.mostrarDetalhes();
  laptopProgramacao.mostrarDetalhes();
}