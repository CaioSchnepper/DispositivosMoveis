enum EnumAcao {
  inibirZonas(0),
  armar(1),
  desarmar(2),
  armarParticao(3), // Usado em testes para centrais Compatec
  desarmarParticao(4), // Usado em testes para centrais Compatec
  ligarSirene(5), // Usado para centrais Vetti
  desligarSirene(6), // Usado para centrais Vetti
  pgm(11),
  restaurarZonas(12); // Usado em testes para centrais Compatec

  const EnumAcao(this.value);
  final num value;
}
