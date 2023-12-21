import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final Function(DateTime?)
      onDateSelected; // Callback para enviar la fecha seleccionada
  final String label;

  const DatePickerWidget({
    required this.onDateSelected,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            _seleccionarFecha(context); // Mostrar el selector de fecha
          },
          child: Text('Seleccionar fecha $label'),
        ),
      ],
    );
  }

  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? fechaActual = DateTime.now();

    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: fechaActual!,
      firstDate: fechaActual,
      lastDate:
          DateTime(2100), // Fecha máxima seleccionable (ejemplo: año 2100)
    );

    if (fechaSeleccionada != null) {
      onDateSelected(
          fechaSeleccionada); // Enviar la fecha seleccionada al padre
    }
  }
}
