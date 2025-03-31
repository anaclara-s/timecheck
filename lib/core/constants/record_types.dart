class RecordTypeConstant {
  // Tipos no frontend
  static const String checkIn = 'check_in';
  static const String startBreak = 'start_break';
  static const String endBreak = 'end_break';
  static const String checkOut = 'check_out';
  static const String completed = 'completed';

  // Mapeamento para o backend
  static const Map<String, String> toBackend = {
    checkIn: 'entrada',
    startBreak: 'saida_intervalo',
    endBreak: 'volta_intervalo',
    checkOut: 'saida_final',
  };

  static const Map<String, String> typeDisplayNames = {
    'entrada': 'Entrada',
    'saida_intervalo': 'Saída Intervalo',
    'volta_intervalo': 'Volta Intervalo',
    'saida_final': 'Saída Final',
  };

  // Método para obter o tipo correspondente no backend
  static String getBackendType(String frontendType) {
    return toBackend[frontendType] ?? 'entrada';
  }

  // Textos para exibição
  static const Map<String, String> toDisplayText = {
    checkIn: 'Registrar entrada',
    startBreak: 'Registrar saída intervalo',
    endBreak: 'Registrar volta intervalo',
    checkOut: 'Registrar saída',
    completed: 'Jornada finalizada',
  };

  // Método para obter texto de exibição
  static String getDisplayText(String type) {
    return toDisplayText[type] ?? 'Marcar ponto';
  }
}
