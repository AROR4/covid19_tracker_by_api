import 'package:covid19_tracker_by_api/Services/Utilities/app_url.dart';
import 'package:http/http.dart'as http;
import '../Model/world_states_api.dart';


import 'dart:convert';

class Stateservices{
  Future<WorldStatesApi> fetchWorldStatesRecords()async {
    final response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStatesApi.fromJson(data);
    }
    else {
      throw Exception('error');
    }
  }

    Future<dynamic> countrieslistapi()async{
     var data;
      final response= await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));

      if(response.statusCode==200){
         data=jsonDecode(response.body.toString());
        return data;
      }
      else{
        throw Exception('error');
      }
  }
}