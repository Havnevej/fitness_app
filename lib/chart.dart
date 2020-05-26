/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate
    );
  }
  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesWeight, DateTime>> createSampleData(List<DateTime> dates, List<int> weights) {
    var data = <TimeSeriesWeight>[];
    for(var i=0; i<weights.length; i++){
      data.add(TimeSeriesWeight(dates[i], weights[i]));
    }

    return [
      charts.Series<TimeSeriesWeight, DateTime>(
        id: 'Weight History',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesWeight DateSeries, _) => DateSeries.time,
        measureFn: (TimeSeriesWeight WeightProgress, _) => WeightProgress.weight,
        data: data,
      )
    ];
  }
}
/// Time series data type.
class TimeSeriesWeight {
  final DateTime time;
  final int weight;
  TimeSeriesWeight(this.time, this.weight);
}