
part of '../view.dart';
class WeatherSection extends StatefulWidget {
  const WeatherSection({super.key});

  @override
  State<WeatherSection> createState() => _WeatherSectionState();
}

class _WeatherSectionState extends State<WeatherSection> {
  @override
  Widget build(BuildContext context) {
    return city!=null?FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              ],
            );
          }
          else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString(),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 28),));
          }else{
            return Center(child: CircularProgressIndicator(color: Colors.green,backgroundColor: Colors.blue,strokeWidth: 8,));
          }
        },
    ):SizedBox.shrink();
  }
}
