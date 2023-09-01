import 'package:covid19_tracker_by_api/View/world_states.dart';
import 'package:flutter/material.dart';


class detailscreen extends StatefulWidget {
  String name,image;
  int totalcases,totaldeaths,totalrecovered,active,critical,todayrecovered,todaycases,test;

  detailscreen({required this.name,required this.image,required this.totalcases,required this.totaldeaths,required this.totalrecovered,required this.active,
    required this.critical,required this.todaycases,required this.todayrecovered,required this.test});

  @override
  State<detailscreen> createState() => _detailscreenState();
}

class _detailscreenState extends State<detailscreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height *0.06,),
                          Reusablerow(value: widget.totalcases.toString(), title: 'Cases'),
                          Reusablerow(value: widget.todayrecovered.toString(), title: 'Recovered'),
                          Reusablerow(value: widget.totaldeaths.toString(), title: 'Deaths'),
                          Reusablerow(value: widget.active.toString(), title: 'Active'),
                          Reusablerow(value: widget.critical.toString(), title: 'Critical'),
                          Reusablerow(value: widget.todaycases.toString(), title: 'Today Cases'),
                          Reusablerow(value: widget.todayrecovered.toString(), title: 'Today Recovered'),
                          Reusablerow(value: widget.test.toString(), title: 'Total Test'),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(radius: 50,
                  backgroundImage: NetworkImage(widget.image.toString()),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
