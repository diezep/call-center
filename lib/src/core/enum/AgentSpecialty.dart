import 'dart:math';

enum AgentSpeciality {
  SERVERS,
  DESKTOPS,
  LAPTOPS,
  PRINTERS,
  COMPUTER_NETWORKS,
  LINUX,
  NO_SELECTED
}

String agentSpecialityToString(AgentSpeciality _) => {
      AgentSpeciality.SERVERS: 'SERVIDORES',
      AgentSpeciality.DESKTOPS: 'ESCRITORIOS',
      AgentSpeciality.LAPTOPS: 'PORTATILES',
      AgentSpeciality.PRINTERS: 'IMPRESORAS',
      AgentSpeciality.COMPUTER_NETWORKS: 'REDES',
      AgentSpeciality.NO_SELECTED: 'NS'.toUpperCase(),
      AgentSpeciality.LINUX: 'LINUX'
    }[_];

AgentSpeciality agentSpecialityFromString(String _) => {
      'SERVIDORES': AgentSpeciality.SERVERS,
      'ESCRITORIOS': AgentSpeciality.DESKTOPS,
      'PORTATILES': AgentSpeciality.LAPTOPS,
      'IMPRESORAS': AgentSpeciality.PRINTERS,
      'REDES': AgentSpeciality.COMPUTER_NETWORKS,
      'NS': AgentSpeciality.NO_SELECTED,
      'LINUX': AgentSpeciality.LINUX
    }[_];

AgentSpeciality getRandomAgentSpeciality() => {
      0: AgentSpeciality.SERVERS,
      1: AgentSpeciality.DESKTOPS,
      2: AgentSpeciality.LAPTOPS,
      3: AgentSpeciality.PRINTERS,
      4: AgentSpeciality.COMPUTER_NETWORKS,
      5: AgentSpeciality.LINUX,
    }[Random().nextInt(6)];
