enum DataType {
  IMAGES,
  AGENTS,
  CLIENTS,
  CALLS,
}

String dataTypeToString(DataType _) => {
      DataType.IMAGES: 'Imagenes',
      DataType.AGENTS: 'Agentes',
      DataType.CLIENTS: 'Clientes',
      DataType.CALLS: 'Llamadas',
    }[_];

DataType dataTypeFromString(String _) => {
      'Imagenes': DataType.IMAGES,
      'Agentes': DataType.AGENTS,
      'Clientes': DataType.CLIENTS,
      'Llamadas': DataType.CALLS,
    }[_];
