// widgets/radar_chart_widget.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/question_models.dart';

class AptitudeRadarChart extends StatelessWidget {
  final AptitudeScores scores;

  const AptitudeRadarChart({super.key, required this.scores});

  @override
  Widget build(BuildContext context) {
    return RadarChart(
      RadarChartData(
        radarTouchData: RadarTouchData(enabled: false),
        dataSets: [
          RadarDataSet(
            fillColor: const Color(0xFF6366F1).withAlpha(51),
            borderColor: const Color(0xFF6366F1),
            borderWidth: 2,
            dataEntries: [
              RadarEntry(value: scores.verbal * 5),
              RadarEntry(value: scores.logical * 5),
              RadarEntry(value: scores.spatial * 5),
              RadarEntry(value: scores.numerical * 5),
            ],
          ),
        ],
        radarShape: RadarShape.polygon,
        radarBorderData: const BorderSide(color: Colors.transparent),
        titlePositionPercentageOffset: 0.2,
        getTitle: (index, angle) {
          switch (index) {
            case 0:
              return RadarChartTitle(text: 'Verbal', angle: angle);
            case 1:
              return RadarChartTitle(text: 'Logical', angle: angle);
            case 2:
              return RadarChartTitle(text: 'Spatial', angle: angle);
            case 3:
              return RadarChartTitle(text: 'Numerical', angle: angle);
            default:
              return const RadarChartTitle(text: '');
          }
        },
        tickCount: 5,
        ticksTextStyle: const TextStyle(fontSize: 10, color: Colors.transparent),
        tickBorderData: BorderSide(color: Colors.grey[300]!, width: 1),
        gridBorderData: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
    );
  }
}

class InterestRadarChart extends StatelessWidget {
  final InterestScores scores;

  const InterestRadarChart({super.key, required this.scores});

  @override
  Widget build(BuildContext context) {
    return RadarChart(
      RadarChartData(
        radarTouchData: RadarTouchData(enabled: false),
        dataSets: [
          RadarDataSet(
            fillColor: const Color(0xFF10B981).withAlpha(51),
            borderColor: const Color(0xFF10B981),
            borderWidth: 2,
            dataEntries: [
              RadarEntry(value: scores.realistic * 5),
              RadarEntry(value: scores.investigative * 5),
              RadarEntry(value: scores.artistic * 5),
              RadarEntry(value: scores.social * 5),
              RadarEntry(value: scores.enterprising * 5),
              RadarEntry(value: scores.conventional * 5),
            ],
          ),
        ],
        radarShape: RadarShape.polygon,
        radarBorderData: const BorderSide(color: Colors.transparent),
        titlePositionPercentageOffset: 0.15,
        getTitle: (index, angle) {
          const titles = ['R', 'I', 'A', 'S', 'E', 'C'];
          return RadarChartTitle(
            text: titles[index],
            angle: angle,
          );
        },
        tickCount: 5,
        ticksTextStyle: const TextStyle(fontSize: 10, color: Colors.transparent),
        tickBorderData: BorderSide(color: Colors.grey[300]!, width: 1),
        gridBorderData: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
    );
  }
}