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
      AgentSpeciality.NoSelected: 'No seleccionado'.toUpperCase()
    }[_];
