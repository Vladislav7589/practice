import 'package:flutter/material.dart';
import 'homePage.dart';

class WeatherPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WeatherPageState();
  }
}

class WeatherPageState extends State<WeatherPage> {
  var arguments;
  late String name;
  late Date date;
  TextEditingController testField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)?.settings.arguments as Map;
    date = arguments['user'];
    name = arguments['name'];
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(splashRadius: 25,icon: Icon(Icons.settings), onPressed: () {  },)
          ],
          title: Text("Weather Page"),
        ),
        body: _buildBody()
    );
  }
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(children: [
        _headerImage(),
        SafeArea(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _textBlock (),
              Divider(),
              _temperature (),
              Divider(),
              _temperatureForecast(),
              Divider(),
              _rating(),
              Divider(),
              _returnData()
            ],
          ),
        )),

      ],),
    );
  }

  Image _headerImage () {
    return Image.asset(
      "assets/image/weather.jpg",
      fit: BoxFit.contain,
    );
  }

  Widget _textBlock () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("${this.name} - ${this.date.month} ${this.date.number}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
        Divider(),
        Text("Погода в России ожидается пасмурная и теплая. Вероятность осадков 0%. Атмосферное давление в пределах нормы (746—749 мм рт.ст.). Температура воздуха +22...+31°C. Ветер слабый (1—3 м/с). Относительная влажность 21—54%."),
      ],
    );
  }

  Divider _divider () {
    return  Divider(
      thickness: 1,
      color: Colors.black54,
      indent: 20,
      endIndent: 20,
    );
  }

  Row _temperature () {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Icon(Icons.wb_sunny,color: Colors.amber,),
          ],
        ),
        SizedBox(width: 16,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("15°C Ясно",style: TextStyle(color: Colors.deepPurpleAccent),),
            Text("Омская область, Омск",style: TextStyle(color: Colors.black26,)),
          ],)
      ],);
  }

  Wrap _temperatureForecast() {
    return Wrap(
      spacing: 5.0,

      children: List.generate(8, (int index) {
        return Chip(
          label: Text(
            '${index + 20} °C',
            style: const TextStyle(fontSize: 15.0),
          ),
          avatar: Icon(
            Icons.wb_twighlight,
            color: Colors.amber,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: Colors.grey),
          ),
          backgroundColor: Colors.grey.shade100,
        );
      }),
    );
  }

  Row _rating() {
    var stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, size: 15.0, color: Colors.yellow[600]),
        Icon(Icons.star, size: 15.0, color: Colors.yellow[600]),
        Icon(Icons.star, size: 15.0, color: Colors.yellow[600]),
        const Icon(Icons.star, size: 15.0,),
        const Icon(Icons.star, size: 15.0,),
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'Rating:',
          style: TextStyle(fontSize: 15.0),
        ),
        stars,
      ],
    );
  }

  Widget _returnData(){
    return Column(children: [
      TextField(controller: testField,),
      RaisedButton(
        child: Text("Return data"),
          onPressed: (){
            String newMassage = testField.text;
            Navigator.pop(context, newMassage);
      })
    ],);
  }

}

