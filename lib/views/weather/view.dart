import 'package:flutter/material.dart';

import '../../apis/apis_service.dart';

part 'compoents/weather.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

final keyForm=GlobalKey<FormState>();
final cityController=TextEditingController(text: "");
String? city;

ApiServices apiServices = ApiServices();
late var future;

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather data"),
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 24),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.only(top: 16,start: 24,end: 24),
          child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _cityTextSearch(),
                SizedBox(height: 16,),
                _searchButton() ,
                SizedBox(height: 24,),
                WeatherSection()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cityTextSearch(){
    return  TextFormField(
      controller: cityController,
      validator: (value) {
        if(value!.isEmpty)
          return "Must enter city name";
        else if(value.length <3)
          return "Invalid city name";
        else return null;
      },
      decoration: InputDecoration(
          alignLabelWithHint: true,
          prefix: Icon(Icons.camera_indoor_outlined,color: Colors.orange,),
          suffix: Icon(Icons.search,color: Colors.red,),
          labelText: "City",
          labelStyle: TextStyle(color: Colors.orange),
          hintText: "Enter city name",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.red)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.orange)
          )
      ),
    );
  }

  Widget _searchButton(){
    return    SizedBox(
      height: 55,
      child: FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.yellow,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.orange)
            ),
          ),
          onPressed: () {
            if(keyForm.currentState!.validate()){
              city=cityController.text;
              future=apiServices.fetchWeatherData(city!);
            }
          }, icon: Icon(Icons.search,size: 32,color: Colors.green,), label: Text("Serarch",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 21,fontWeight: FontWeight.w600))),
    );
  }
}
