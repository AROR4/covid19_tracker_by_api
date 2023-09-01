import 'package:covid19_tracker_by_api/Services/states_services.dart';
import 'package:covid19_tracker_by_api/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Countrieslistscreen extends StatefulWidget {
  const Countrieslistscreen({super.key});

  @override
  State<Countrieslistscreen> createState() => _CountrieslistscreenState();
}

class _CountrieslistscreenState extends State<Countrieslistscreen> {
  var searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Stateservices stateServices = Stateservices();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchcontroller,
                onChanged: (value){

                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Sesarch with Country Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: stateServices.countrieslistapi(),
                    builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context,index){
                            return Column(
                              children: [
                                ListTile(
                                  title: Container(height: 10,width: 80,color: Colors.white,),
                                  subtitle: Container(height: 10,width: 80,color: Colors.white,),
                                  leading: Container(height: 50,width: 50,color: Colors.white,),
                                )
                              ],
                            );
                          })
                    );
                  }
                  else{
                    return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                            var name=snapshot.data![index]['country'];
                            if(searchcontroller.text.isEmpty){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> detailscreen(name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        totalcases: snapshot.data![index]['cases'],
                                        totaldeaths: snapshot.data![index]['deaths'],
                                        totalrecovered: snapshot.data![index]['recovered'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]['critical'],
                                        todaycases: snapshot.data![index]['todayCases'],
                                        todayrecovered: snapshot.data![index]['todayRecovered'],
                                        test: snapshot.data![index]['tests'],)));
                                    },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country'].toString()),
                                      subtitle: Text('Affected: ' + snapshot.data[index]['cases'].toString()),
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                    ),
                                  )
                                ],
                              );
                            }
                            else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> detailscreen(name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        totalcases: snapshot.data![index]['cases'],
                                        totaldeaths: snapshot.data![index]['deaths'],
                                        totalrecovered: snapshot.data![index]['recovered'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]['critical'],
                                        todaycases: snapshot.data![index]['todayCases'],
                                        todayrecovered: snapshot.data![index]['todayRecovered'],
                                        test: snapshot.data![index]['tests'],)));
                                    },
                                    child: ListTile(
                                      title: Text(snapshot.data[index]['country'].toString()),
                                      subtitle: Text('Affected: ' + snapshot.data[index]['cases'].toString()),
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),)),
                                  ),

                                ],
                              );
                            }
                            else{
                                return Container();
                            }

                          },
                    );

                  }

                }) )
          ],
        ),
      ),
    );
  }
}
