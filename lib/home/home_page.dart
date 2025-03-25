import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/api_service.dart';
import 'widget/clock_widget.dart';
import 'widget/greeting_widget.dart';
import '../shared/widgets/custom_appbar.dart';
import '../shared/widgets/custom_bottom_navigator_bar.dart';
import '../shared/widgets/custom_text_button.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final int idFuncionario;

  HomePage({
    super.key,
    required this.userName,
    required this.idFuncionario,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _proximoRegistro = 'entrada';
  bool _isLoading = false;
  List<dynamic> _ultimosRegistros = [];

  @override
  void initState() {
    super.initState();
    _proximoRegistro = 'entrada'; // Valor inicial
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carregarUltimosRegistros();
    });
  }

  Future<void> _carregarUltimosRegistros() async {
    print('Carregando registros...');
    try {
      final registros = await ApiService.getRegistros(widget.idFuncionario);
      print('Registros recebidos: ${registros.length}');

      setState(() {
        _ultimosRegistros = registros;
        _determinarProximoRegistro();
      });
    } catch (e) {
      print('Erro detalhado: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Erro ao carregar registros: ${e.toString().replaceAll('Exception: ', '')}'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _determinarProximoRegistro() {
    final hoje = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print('Data atual: $hoje');

    // Filtra registros do dia atual
    final registrosHoje = _ultimosRegistros.where((r) {
      final dataRegistro =
          r['data'].toString().split(' ')[0]; // Pega apenas a parte da data
      return dataRegistro == hoje;
    }).toList()
      ..sort((a, b) =>
          b['horario'].compareTo(a['horario'])); // Ordena do mais recente

    print('Registros de hoje: ${registrosHoje.length}');

    if (registrosHoje.isEmpty) {
      print('Nenhum registro hoje - definindo como entrada');
      setState(() => _proximoRegistro = 'entrada');
      return;
    }

    final ultimo = registrosHoje.first;
    print('Último registro: ${ultimo['tipo_registro']}');

    switch (ultimo['tipo_registro']) {
      case 'entrada':
        setState(() => _proximoRegistro = 'saida_intervalo');
        break;
      case 'saida_intervalo':
        setState(() => _proximoRegistro = 'volta_intervalo');
        break;
      case 'volta_intervalo':
        setState(() => _proximoRegistro = 'saida_final');
        break;
      case 'saida_final':
        setState(() =>
            _proximoRegistro = 'entrada'); // Novo dia começará com entrada
        break;
      default:
        setState(() => _proximoRegistro = 'entrada');
    }
  }

  Future<void> _registrarPonto() async {
    final hoje = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Verifica se já completou o ciclo hoje
    final registrosHoje = _ultimosRegistros
        .where((r) => r['data'].toString().contains(hoje))
        .toList();
    final jaCompleto =
        registrosHoje.any((r) => r['tipo_registro'] == 'saida_final');

    if (jaCompleto) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jornada já registrada hoje')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ApiService.registrarPonto(
        widget.idFuncionario,
        _proximoRegistro,
      );

      await _carregarUltimosRegistros();
    } catch (e) {
      print('Erro ao registrar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getTextoBotao() {
    print('Chamando _getTextoBotao(), _proximoRegistro: $_proximoRegistro');
    switch (_proximoRegistro) {
      case 'entrada':
        return 'Registrar Entrada';
      case 'saida_intervalo':
        return 'Registrar Saída Intervalo';
      case 'volta_intervalo':
        return 'Registrar Volta Intervalo';
      case 'saida_final':
        return 'Registrar Saída';
      default:
        return 'Marcar Ponto';
    }
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Próximo registro: $_proximoRegistro'),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _proximoRegistro = _proximoRegistro == 'entrada'
//                       ? 'saida_intervalo'
//                       : 'entrada';
//                 });
//               },
//               child: Text(_getTextoBotao()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    final textoBotao = _getTextoBotao();
    print('Texto do botão calculado: $textoBotao');
    print('BUILD - Próximo registro: $_proximoRegistro');

    return Scaffold(
      appBar: CustomAppbarWidget(
        text: 'Marcação de ponto',
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 80, 184, 216),
              // gradient: LinearGradient(
              //   colors: [Colors.cyanAccent, Colors.deepPurpleAccent],
              // ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(200),
                bottomRight: Radius.circular(200),
              ),
            ),
            child: Column(
              children: [
                GreetingWidget(userName: widget.userName),
                SizedBox(height: 50),
                ClockWidget(),
              ],
            ),
          ),
          CustomTextButtonWidget(
            key: ValueKey(
                _proximoRegistro), // Isso força a reconstrução quando muda
            onPressed: _registrarPonto,
            text: _getTextoBotao(),
            isLoading: _isLoading,
          ),
          Text('Últimas marcações'),
          Expanded(
            child: ListView.builder(
              itemCount: _ultimosRegistros.length,
              itemBuilder: (context, index) {
                final registro = _ultimosRegistros[index];
                return ListTile(
                  title: Text('${registro['data']} ${registro['horario']}'),
                  subtitle:
                      Text(_formatarTipoRegistro(registro['tipo_registro'])),
                );
              },
            ),
          ),
          CustomBottomNavigatorBarWidget(),
        ],
      ),
    );
  }

  String _formatarTipoRegistro(String tipo) {
    switch (tipo) {
      case 'entrada':
        return 'Registrar entrada';
      case 'saida_intervalo':
        return 'Registrar saída intervalo';
      case 'volta_intervalo':
        return 'Registrar volta intervalo';
      case 'saida_final':
        return 'Registrar saída';
      default:
        return tipo;
    }
  }
}
