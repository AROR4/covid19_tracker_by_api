import 'dart:async';
import '../Model/world_states_api.dart';
import 'package:covid19_tracker_by_api/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Countrieslist.dart';
class worldstates extends StatefulWidget {
  const worldstates({super.key});

  @override
  State<worldstates> createState() => _worldstatesState();
}

class _worldstatesState extends State<worldstates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa220),
    Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    Stateservices stateServices= Stateservices();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(MediaQuery.of(context).size.height* .01),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                FutureBuilder(
                  future: stateServices.fetchWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesApi> snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ));
                    }
                    else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(snapshot.data!.cases!.toString()),
                              "Recoverd": double.parse(snapshot.data!.recovered!.toString()),
                              "Death": double.parse(snapshot.data!.deaths!.toString())
                            },
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            colorList: colorList,
                            chartRadius: MediaQuery.of(context).size.width / 2.5,
                            chartType: ChartType.ring,
                            legendOptions:
                            const LegendOptions(legendPosition: LegendPosition.left),
                            // animationDuration: const Duration(microseconds: 12000),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.08),
                            child: Card(
                              child: Column(
                                children: [
                                  Reusablerow(value: snapshot.data!.cases.toString(), title: 'Total'),
                                  Reusablerow(value: snapshot.data!.recovered.toString(), title: 'Recovered'),
                                  Reusablerow(value: snapshot.data!.deaths.toString(), title: 'Deaths'),
                                  Reusablerow(value: snapshot.data!.active.toString(), title: 'Active'),
                                  Reusablerow(value: snapshot.data!.critical.toString(), title: 'Critical'),
                                  Reusablerow(value: snapshot.data!.todayDeaths.toString(), title: 'Today Deaths'),
                                  Reusablerow(value: snapshot.data!.todayRecovered.toString(), title: 'Today Recovered'),
          
                                ],
                              ),
                            ),
          
                          ),
          
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Countrieslistscreen()));
                           },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xff1aa220),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text("Track Countries"),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  },),
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Reusablerow extends StatelessWidget {
  String title, value;
  Reusablerow({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10,bottom: 5),
      child: Column(
        children: [
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title),
                  Text(value),
                ],
              ),
          SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}
