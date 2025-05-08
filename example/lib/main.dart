import 'package:delux_chart/delux_chart.dart';

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestDeluxChart(),
    );
  }
}

class TestDeluxChart extends StatelessWidget {
  const TestDeluxChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delux Chart'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const AspectRatio(
            aspectRatio: 16 / 9,
            child: DeluxBarChart(
              data: [
                ChartData('Mon', 10),
                ChartData('Tue', 15),
                ChartData('Wed', 19),
                ChartData('Thu', 12.5),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ColoredBox(
            color: Colors.amber.withAlpha(0),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: DeluxBarChart(
                // direction: Axis.vertical,
                axisLine: const AxisLine(
                  bottom: LineStyle(color: Colors.red, thickness: 4),
                  left: LineStyle(color: Colors.blue, thickness: 4),
                  right: LineStyle(color: Colors.green, thickness: 4),
                  top: LineStyle(color: Colors.yellow, thickness: 4),
                  position: AxisLinePosition.foreground,
                ),
                domainAxis: DomainAxis(
                  gapTickLabel: 0,
                  gridLineStyle:
                      const LineStyle(color: Colors.green, thickness: 4),
                  labelFormatter: (label) => '$label day',
                  labelOffset: const Offset(0, 0),
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  labelWidget: (label) => switch (label) {
                    'Wed' => const Icon(Icons.weekend),
                    _ => null,
                  },
                  tickLength: 6,
                  tickStyle:
                      const TickStyle(color: Colors.purple, thickness: 2),
                  // viewport: DeluxViewport('Mon', 'Thu'),
                  xAxisLabelSpace: 24,
                ),
                measureAxis: MeasureAxis(
                  gridLineStyle:
                      const LineStyle(color: Colors.black, thickness: 4),
                  crossAxisAlignment: CrossAxisAlignment.end,
                  gapTickLabel: 5,
                  tickCount: 5,
                  labelFormatter: (label) => '${label.toStringAsFixed(1)} kg',
                  labelOffset: const Offset(0, 0),
                  labelStyle: const TextStyle(fontSize: 10),
                  labelWidget: (label) {
                    if (label > 17) return const Text('😤');
                    if (label == 0) return null;
                    if (label < 6) return const Text('😡');
                    return null;
                  },
                  tickLength: 6,
                  tickStyle:
                      const TickStyle(color: Colors.blueAccent, thickness: 2),
                  // viewport: DeluxViewport(0, 20),
                  xAxisLabelSpace: 20,
                ),
                configSeriesBar: ConfigSeriesBar(
                  backgroundSpecFn: (item, index) => BackgroundSpec(
                    color: Colors.green.withAlpha(120),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.green,
                        Colors.green.withAlpha(120),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // barWidth: 50,
                  baseColor: Colors.green,
                  borderRadiusFn: (item, index) =>
                      const BorderRadius.only(topLeft: Radius.circular(20)),
                  colorFn: (item, index) => Colors.pink,
                  fillColorFn: (item, index) => Colors.cyan,
                  fillGradientFn: (item, index) => const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.lightBlueAccent,
                      Colors.purpleAccent,
                    ],
                  ),
                  labelPositionFn: (item, index) => LabelPosition.inside,
                  labelSpecFn: (item, index) => switch (index) {
                    1 => const LabelSpec(
                        labelWidget: Icon(
                          Icons.change_circle,
                          color: Colors.white,
                        ),
                      ),
                    _ => LabelSpec(
                        label: item.measure.toString(),
                        labelAlignment: Alignment.topCenter,
                        labelPadding: const EdgeInsets.only(top: 8),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                  },
                  onTap: (item) {
                    debugPrint(item.toString());
                  },
                  strokeColorFn: (item, index) => Colors.green,
                  strokeWidthFn: (item, index) => 6,
                  strokeGradientFn: (item, index) => const SweepGradient(
                    colors: [Colors.green, Colors.amber],
                    transform: GradientRotation(pi / 180 * -45),
                  ),
                  tooltipSpecFn: (item, index) => TooltipSpec(
                    richMessage: TextSpan(text: item.measure.toString()),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(blurRadius: 10, color: Colors.black38),
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Colors.amber.withAlpha(120),
                          Colors.purple.withAlpha(120),
                        ],
                      ),
                    ),
                    verticalOffset: 0,
                  ),
                ),
                data: const [
                  ChartData('Mon', 10),
                  ChartData('Tue', 15),
                  ChartData('Wed', 19),
                  ChartData('Thu', 12.5),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
