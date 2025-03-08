import 'package:flutter/material.dart';
import 'package:flareline/pages/dashboard/grid_card.dart';
import 'package:flareline/pages/layout.dart';

import 'SensorDataWidget.dart';

class Dashboard extends LayoutWidget {
  const Dashboard({super.key});

  @override
  String breakTabTitle(BuildContext context) {
    return 'Dashboard';
  }

  @override
  Widget contentDesktopWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Grid Cards (3 per row)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 16, // Spacing between cards horizontally
                mainAxisSpacing: 16, // Spacing between cards vertically
                childAspectRatio: 1.5, // Adjust the aspect ratio as needed
              ),
              itemCount: 10, // Number of grid cards
              itemBuilder: (context, index) {
                // List of sensors
                final List<Map<String, String>> sensors = [
                  {"name": "Temperature", "value": "25°C"},
                  {"name": "Humidity", "value": "60%"},
                  {"name": "Speed", "value": "45 T/m"},
                  {"name": "Pressure", "value": "1013 hPa"},
                  {"name": "Tension", "value": "60 V"},
                  {"name": "Courant", "value": "5 A"},
                  {"name": "Couple", "value": "10 N"},
                  {"name": "Vibration", "value": "20"},
                  {"name": "Efficiency", "value": "90 %"},
                  {"name": "Push", "value": "20"},
                ];

                // Get the sensor data for the current index
                final sensor = sensors[index];

                return GridCard(
                  name: sensor["name"]!,
                  value: sensor["value"]!,
                );
              },
            ),
            const SizedBox(height: 16),

            // Charts (2 per row)
            Column(
              children: [
                const SizedBox(height: 16), // Spacing between rows
                // Second row of charts
                Row(
                  children: const [
                    Expanded(
                      child: SensorDataWidget(), // Third chart
                    ),
                    SizedBox(width: 16), // Spacing between charts
                    Expanded(
                      child: SensorDataWidget(), // Fourth chart
                    ),
                    SizedBox(width: 16), // Spacing between charts
                    Expanded(
                      child: SensorDataWidget(), // Fourth chart
                    ),
                  ],
                ),
                const SizedBox(height: 16), // Spacing between rows
                Row(
                  children: const [
                    Expanded(
                      child: SensorDataWidget(), // Third chart
                    ),
                    SizedBox(width: 16), // Spacing between charts
                    Expanded(
                      child: SensorDataWidget(), // Fourth chart
                    ),
                    SizedBox(width: 16), // Spacing between charts
                    Expanded(
                      child: SensorDataWidget(), // Fourth chart
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget contentMobileWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Grid Cards (1 per row on mobile)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // 1 card per row on mobile
                crossAxisSpacing: 16, // Spacing between cards horizontally
                mainAxisSpacing: 16, // Spacing between cards vertically
                childAspectRatio: 1.5, // Adjust the aspect ratio as needed
              ),
              itemCount: 7, // Number of grid cards
              itemBuilder: (context, index) {
                // List of sensors
                final List<Map<String, String>> sensors = [
                  {"name": "Temperature", "value": "25°C"},
                  {"name": "Humidity", "value": "60%"},
                  {"name": "Pressure", "value": "1013 hPa"},
                  {"name": "Tension", "value": "60 V"},
                  {"name": "Courant", "value": "5 A"},
                  {"name": "Couple", "value": "10 N"},
                  {"name": "Vibration", "value": "20"},
                ];

                // Get the sensor data for the current index
                final sensor = sensors[index];

                return GridCard(
                  name: sensor["name"]!,
                  value: sensor["value"]!,
                );
              },
            ),
            const SizedBox(height: 16),

            // Charts (1 per row on mobile)
            Column(
              children: const [
                SensorDataWidget(), // First chart
                SizedBox(height: 16), // Spacing between charts
                SensorDataWidget(), // Second chart
                SizedBox(height: 16), // Spacing between charts
                SensorDataWidget(), // Third chart
                SizedBox(height: 16), // Spacing between charts
                SensorDataWidget(), // Fourth chart
                SizedBox(height: 16), // Spacing between charts
                SensorDataWidget(), // Fifth chart
                SizedBox(height: 16), // Spacing between charts
                SensorDataWidget(), // Sixth chart
              ],
            ),
          ],
        ),
      ),
    );
  }
}