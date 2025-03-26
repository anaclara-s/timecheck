import 'package:flutter/material.dart';

import '../constants/record_types.dart';
import 'custom_text_button.dart';

class RecordButtonWidget extends StatelessWidget {
  final String recordType;
  final bool isLoading;
  final VoidCallback onPressed;

  const RecordButtonWidget({
    super.key,
    required this.recordType,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextButtonWidget(
      onPressed: recordType == RecordTypeConstant.completed ? () {} : onPressed,
      text: _getButtonText(),
      isLoading: isLoading,
      isEnabled: recordType != RecordTypeConstant.completed,
    );
  }

  String _getButtonText() {
    switch (recordType) {
      case RecordTypeConstant.checkIn:
        return 'Registrar Entrada';
      case RecordTypeConstant.startBreak:
        return 'Registrar Saída Intervalo';
      case RecordTypeConstant.endBreak:
        return 'Registrar Volta Intervalo';
      case RecordTypeConstant.checkOut:
        return 'Registrar Saída';
      case RecordTypeConstant.completed:
        return 'Jornada Finalizada';
      default:
        return 'Marcar Ponto';
    }
  }
}
