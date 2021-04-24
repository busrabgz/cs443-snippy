import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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
  final int unit, offset;
  final RangeValues timeRange;
  final String mode;

  @override
  Graph({
    Key key,
    this.data,
    this.unit,
    this.timeRange,
    this.offset,
    this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transformer = (List<Request> input) {
      var timeNow = DateTime.now().millisecondsSinceEpoch;
      var map = Map<int, int>();
      var counts = Map<int, int>();

      for (var i = timeRange.start.toInt(); i <= timeRange.end.toInt(); i++) {
        map[i] = 0;
        counts[i] = 0;
      }

      if (input != null && this.mode == 'Visits') {
        var reduced =
            input.map((e) => (timeNow - offset - e.incomingTime) ~/ unit);
        reduced.forEach((element) {
          if (element >= timeRange.start && element <= timeRange.end)
            map[element] += 1;
        });
      } else if (input != null && this.mode == 'Latency') {
        var reduced = input.map((e) => [
              (timeNow - e.incomingTime) ~/ unit,
              e.outgoingTime - e.incomingTime
            ]);

        reduced.forEach((element) {
          if (element[0] >= timeRange.start && element[0] <= timeRange.end) {
            counts[element[0]] += 1;
            map[element[0]] += element[1];
          }
        });

        for (int i = timeRange.start.toInt(); i <= timeRange.end.toInt(); i++) {
          if (counts[i] > 0) {
            map[i] ~/= counts[i];
          }
        }

        var lastStop = -1;
        for (int i = timeRange.start.toInt(); i <= timeRange.end.toInt(); i++) {
          if (map[i] != 0) {
            for (int j = i - 1; j > lastStop; j--) {
              if (map[j] == 0) map[j] = map[i];
            }
            lastStop = i;
          }
        }
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
              legendItemText: mode == 'Latency' ? 'Latency (ms)' : 'Visits',
              dataLabelSettings: DataLabelSettings(isVisible: true)),
        ],
      ),
    );
  }
}

class AnalyticsScreen extends StatefulWidget {
  final String id;

  @override
  AnalyticsScreen({Key key, this.id}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState(id: id);
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List<Request> request;
  RangeValues timeRange = RangeValues(0, 10);
  String id;
  String unitValue = 'Days';
  String modeValue = 'Visits';
  int offset = 0;

  final unitMapping = {
    'Minutes': minute,
    'Hours': hour,
    'Days': day,
    'Weeks': week
  };

  Widget getList(data) => ListView.builder(
      itemCount: data.length + 3,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Row(children: [
            Text('Duration: '),
            DropdownButton<String>(
              value: unitValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Color.fromRGBO(61, 82, 155, 1.0)),
              underline: Container(
                height: 2,
                color: Colors.blue[900],
              ),
              onChanged: (String newValue) {
                setState(() {
                  unitValue = newValue;
                });
              },
              items: <String>['Minutes', 'Hours', 'Days', 'Weeks']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Text('Mode: '),
            DropdownButton<String>(
              value: modeValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Color.fromRGBO(61, 82, 155, 1.0)),
              underline: Container(
                height: 2,
                color: Colors.blue[900],
              ),
              onChanged: (String newValue) {
                setState(() {
                  modeValue = newValue;
                });
              },
              items: <String>['Visits', 'Latency']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            MaterialButton(
              onPressed: () {
                var selectedDate = DateTime.fromMillisecondsSinceEpoch(
                    DateTime.now().millisecondsSinceEpoch - offset);
                showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: selectedDate.subtract(Duration(days: 90)),
                  lastDate: DateTime.now(),
                ).then((value) => setState(() {
                      offset = DateTime.now().millisecondsSinceEpoch -
                          value.millisecondsSinceEpoch;
                    }));
              },
              child: Text('Pick a date'),
            )
          ]);
        } else if (index == 1) {
          return RangeSlider(
            values: timeRange,
            activeColor: Color.fromRGBO(61, 82, 155, 1.0),
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
          );
        } else if (index == 2) {
          return Graph(
            data: data,
            unit: unitMapping[unitValue],
            timeRange: timeRange,
            offset: offset,
            mode: modeValue,
          );
        } else {
          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              data[index - 3].incomingTime);
          DateFormat format = new DateFormat("y-MM-dd-hh:mm");
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
        title: Text('Analytics'),
      ),
      body: FutureBuilder<String>(
          future: FirebaseAuth.instance.currentUser.getIdToken(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return getList(List<Request>.empty());
            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: StreamBuilder<List<Request>>(
                    stream:
                        analyticsApi.getAnalytics(id, snapshot.data).asStream(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? getList(snapshot.data)
                          : getList(List<Request>.empty());
                    }),
              ),
            );
          }),
    );
  }
}
