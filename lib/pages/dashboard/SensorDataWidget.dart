import 'package:flareline_uikit/components/charts/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flareline_uikit/components/card/common_card.dart';
import 'package:responsive_builder/responsive_builder.dart';


class SensorDataWidget extends StatelessWidget {
  const SensorDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _sensorDataWidget();
  }

  Widget _sensorDataWidget() {
    return ScreenTypeLayout.builder(
      desktop: _sensorDataWidgetDesktop,
      mobile: _sensorDataWidgetMobile,
      tablet: _sensorDataWidgetMobile,
    );
  }

  Widget _sensorDataWidgetDesktop(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Row(
        children: [
          Expanded(
            child: _temperatureChart(),
            flex: 2,
          ),
          const SizedBox(width: 16),

        ],
      ),
    );
  }

  Widget _sensorDataWidgetMobile(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 360,
          child: _temperatureChart(),
        ),
        const SizedBox(height: 16),

      ],
    );
  }

  // Temperature Line Chart
  Widget _temperatureChart() {
    return CommonCard(
      child: LineChartWidget(
        title: 'Temperature (°C)',
        dropdownItems: const ['', '', ''],
        datas: const [
          {
            'name': 'Temperature',
            'color': Color(0xFFFE8111), // Orange
            'data': [
              {'x': '00:00', 'y': 25},
              {'x': '01:00', 'y': 26},
              {'x': '02:00', 'y': 27},
              {'x': '03:00', 'y': 26},
              {'x': '04:00', 'y': 25},
              {'x': '05:00', 'y': 24},
              {'x': '06:00', 'y': 25},
              {'x': '07:00', 'y': 26},
              {'x': '08:00', 'y': 27},
              {'x': '09:00', 'y': 28},
              {'x': '10:00', 'y': 29},
              {'x': '11:00', 'y': 30},
            ],
          },
        ],
      ),
    );
  }


}