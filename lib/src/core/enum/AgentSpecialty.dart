enum AgentSpeciality {
  Servidores,
  Escritorios,
  Portatiles,
  Impresoras,
  Redes,
  NoSelected
}
String agentSpecialityToString(AgentSpeciality _) => {
      AgentSpeciality.Servidores: 'Servidores'.toUpperCase(),
      AgentSpeciality.Escritorios: 'Escritorios'.toUpperCase(),
      AgentSpeciality.Portatiles: 'Portatiles'.toUpperCase(),
      AgentSpeciality.Impresoras: 'Impresoras'.toUpperCase(),
      AgentSpeciality.Redes: 'Redes'.toUpperCase(),
      AgentSpeciality.NoSelected: 'NS'.toUpperCase()
    }[_];

AgentSpeciality agentSpecialityFromString(String _) => {
      'Servidores'.toUpperCase(): AgentSpeciality.Servidores,
      'Escritorios'.toUpperCase(): AgentSpeciality.Escritorios,
      'Portatiles'.toUpperCase(): AgentSpeciality.Portatiles,
      'Impresoras'.toUpperCase(): AgentSpeciality.Impresoras,
      'Redes'.toUpperCase(): AgentSpeciality.Redes,
      'NS'.toUpperCase(): AgentSpeciality.NoSelected
    }[_];
