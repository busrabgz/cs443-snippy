import 'package:flutter/material.dart';
import 'package:snippy_ui/screens/Welcome/welcome_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:snippy_analytics_api/api.dart';
import 'package:intl/intl.dart';

const second = 1000;
const minute = 60 * second;
const hour = 60 * minute;
const day = 24 * hour;
const week = 7 * day;

class Graph extends StatelessWidget {
  final List<Request> data;
  final int unit;
  final RangeValues timeRange;

  @override
  Graph({
    Key key,
    this.data,
    this.unit,
    this.timeRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transformer = (List<Request> input) {
      var timeNow = DateTime.now().millisecondsSinceEpoch;
      var map = Map<int, int>();
      for (var i = timeRange.start.toInt(); i <= timeRange.end.toInt(); i++) {
        map[i] = 0;
      }

      if (input != null) {
        var reduced = input.map((e) => (timeNow - e.incomingTime) ~/ unit);
        reduced.forEach((element) {
          if (element >= timeRange.start && element <= timeRange.end)
            map[element] += 1;
        });
      }

      var returnList = map.entries.toList();
      returnList.sort((e, v) => v.key - e.key);

      return returnList;
    };

    return Container(
      height: 500,
      padding: EdgeInsets.only(bottom: 10),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'Number of requests'),
        legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <LineSeries<MapEntry<int, int>, String>>[
          LineSeries<MapEntry<int, int>, String>(
              dataSource: transformer(data),
              xValueMapper: (MapEntry<int, int> req, _) => req.key.toString(),
              yValueMapper: (MapEntry<int, int> req, _) => req.value,
              dataLabelSettings: DataLabelSettings(isVisible: true)),
        ],
      ),
    );
  }
}

class AnalyticsScreen extends StatefulWidget {
  String id;

  @override
  AnalyticsScreen({Key key, this.id}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState(id: id);
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List<Request> request;
  int unit = minute;
  RangeValues timeRange = RangeValues(0, 10);
  int groupValue = minute;
  String id;

  Widget getList(data) => ListView.builder(
      itemCount: data.length + 3,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Row(
            children: [
              Radio(
                value: minute,
                groupValue: groupValue,
                onChanged: (o) {
                  setState(() {
                    unit = minute;
                    groupValue = minute;
                  });
                },
              ),
              Text('M'),
              Radio(
                value: hour,
                groupValue: groupValue,
                onChanged: (o) {
                  setState(() {
                    unit = hour;
                    groupValue = hour;
                  });
                },
              ),
              Text('H'),
              Radio(
                value: day,
                groupValue: groupValue,
                onChanged: (o) {
                  setState(() {
                    unit = day;
                    groupValue = day;
                  });
                },
              ),
              Text('D'),
              Radio(
                value: week,
                groupValue: groupValue,
                onChanged: (o) {
                  setState(() {
                    unit = week;
                    groupValue = week;
                  });
                },
              ),
              Text('W'),
            ],
          );
        } else if (index == 1) {
          return Column(
            children: [
              Text('Range:'),
              RangeSlider(
                values: timeRange,
                min: 0,
                max: 50,
                divisions: 50,
                labels: RangeLabels(
                  timeRange.start.round().toString(),
                  timeRange.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    timeRange = values;
                  });
                },
              ),
            ],
          );
        } else if (index == 2) {
          return Graph(
            data: data,
            unit: unit,
            timeRange: timeRange,
          );
        } else {
          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              data[index - 3].incomingTime);
          DateFormat format = new DateFormat("y-MM-dd-hh-mm");
          final text = format.format(date);
          return Padding(
            padding: EdgeInsets.all(12.0),
            child: Container(
              child: Text(text),
            ),
          );
        }
      });

  @override
  _AnalyticsScreenState({this.id}) : super();

  @override
  Widget build(BuildContext context) {
    final analyticsApi = AnalyticsApplicationApi();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(61, 82, 155, 1.0),
        elevation: 10.0,
        title: Text('Sign Up'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: StreamBuilder<List<Request>>(
              stream: analyticsApi.getAnalytics(id).asStream(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? getList(snapshot.data)
                    : getList(List<Request>.empty());
              }),
        ),
      ),
    );
  }
}
