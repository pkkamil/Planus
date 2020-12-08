import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/circlePerson.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/screens/Flat/Panel/home_screen.dart';
import 'package:planus/screens/Flat/Panel/screens/Counters/InsertCounters_screen.dart';
import 'package:planus/services/apiController.dart';

class FlatScreen extends StatefulWidget {
  
  final FlatInfo flatData;

  FlatScreen(this.flatData);

  @override
  _FlatScreenState createState() => _FlatScreenState();
}

class _FlatScreenState extends State<FlatScreen> {
  int days = 0;

  int months = 0;
  String name;

  List residents = [];

  @override
  void dispose() {
    residents = null;
    super.dispose();
  }

  void getTime(){
    var now = new DateTime.now();

    DateTime onCreated = widget.flatData.updated_at;
    
    days = widget.flatData.settlement_day-now.day;
    if(days<0)
      days = 30+days;

    months = widget.flatData.billing_period-now.difference(onCreated).inDays~/30-1;
  }

  void getResidents() async{
    var api = new Api();
    var response = await api.getResidents(widget.flatData.id_apartment);

    if(response['statusCode']==200){
      if(this.mounted){
        setState(() {
          residents = response['body']['roommates'];
        });
      }
    }
  }

  @override
  void initState() {
    getTime();
    getResidents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //int days = 0;
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height*0.07),
            Container(
              width: size.width*0.7,
              child: Text(
                widget.flatData.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 26
                ),
              ),
            ),
            Text(
              widget.flatData.localization,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 18,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
              width: size.width*0.6,
              height: size.width*0.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.flatData.image),
                  fit: BoxFit.cover
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            Text(
              "Pozostały okres rozliczeniowy:",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 18,
              ),
            ),
            Text(
              (widget.flatData.billing_period==1) ? 'miesiąc' : months.toString()+" miesiące",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.orange,
                fontSize: 18,
              ),
            ),
            SizedBox(height: size.height*0.03),
            if(days!=0)Text(
              "Do terminu rozliczenia",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 18,
              ),
            ),
            if(days!=0)RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 18,
                ),
                children: [
                  TextSpan(text: "pozostało "),
                  TextSpan(text: days.toString(), style: TextStyle(color: Colors.orange)),
                  TextSpan(text: " dni."),
                ]
              ),
            ),
            if(days==0)RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 18,
                ),
                children: [
                  TextSpan(text: "Dziś ", style: TextStyle(color: Colors.orange)),
                  TextSpan(text: "wypada termin rozliczenia."),
                ]
              ),
            ),
            SizedBox(height: size.height*0.03),
            if(days!=0 && (widget.flatData.hot_water>0 || widget.flatData.cold_water>0 || widget.flatData.electricity>0 || widget.flatData.gas>0) && widget.flatData.id_user==widget.flatData.id_owner)RoundedButton(
              horizontal: 40.0,
              text: "Wprowadź liczniki",
              onPress: () {
              },
              isShadow: false,
            ),
            if(days==0 && (widget.flatData.hot_water>0 || widget.flatData.cold_water>0 || widget.flatData.electricity>0 || widget.flatData.gas>0) && widget.flatData.id_user==widget.flatData.id_owner)RoundedButton(
              horizontal: 40.0,
              text: "Wprowadź liczniki",
              onPress: () {
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => InsertCounters(widget.flatData.id_user, widget.flatData.id_apartment)));
              },
              isShadow: false,
              textColor: Colors.orange,
              color: Colors.white,
            ),
            SizedBox(height: size.height*0.05),
            Container(
              width: size.width*0.7,
              child: Text(
                "Mieszkańcy",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              width: size.width*0.75,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                  child: Row(
                  children: [
                    if(residents!=null) for(int i=0;i<residents.length;i++) PersonCircle(
                      size: size, 
                      name: residents[i]['name'],
                      onTap: () {
                        if(widget.flatData.id_user==widget.flatData.id_owner){
                          String resident = residents[i]['name'];
                          return showDialog(context: context,builder: (context) {
                            return AlertDialog(
                              title: Text('Czy chcesz wyrzucić użytkownika $resident z mieszkania?'),
                              actions: [
                              MaterialButton(
                                elevation: 5.0,
                                child: Text('Anuluj'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              MaterialButton(
                                elevation: 5.0,
                                child: Text(
                                  'Potwierdź',
                                  style: TextStyle(color: Colors.orange),
                                ),
                                onPressed: () async{
                                  if(widget.flatData.id_user==widget.flatData.id_owner){
                                    Map data = {
                                      'member_id': residents[i]['id'],
                                      'user_id': widget.flatData.id_user,
                                      'id_apartment': widget.flatData.id_apartment
                                    };
                                    //print(data);
                                    var api = new Api();
                                    var response = await api.kickMember(data);

                                    //print(response);

                                    if(response['message']=='OK'){
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Home(widget.flatData)));
                                    }
                                  }
                                },
                              ),
                            ],
                            );
                          });
                        }
                      },
                    ),
                    if(widget.flatData.id_user==widget.flatData.id_owner)AddPersonCircle(
                      size: size,
                      onTap: () {
                        return showDialog(context: context,builder: (context) {
                          return AlertDialog(
                            title: Text('Wprowadź imię użytkownika'),
                            content: TextField(
                              cursorColor: Colors.orange,
                              onChanged: (val) {
                                name = val;
                              },
                            ),
                            actions: [
                              MaterialButton(
                                elevation: 5.0,
                                child: Text('Anuluj'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              MaterialButton(
                                elevation: 5.0,
                                child: Text(
                                  'Potwierdź',
                                  style: TextStyle(color: Colors.orange),
                                ),
                                onPressed: () async{
                                  if(name.length>0){
                                    Map data = {
                                      'name': name,
                                      'user_id': widget.flatData.id_user,
                                      'id_apartment': widget.flatData.id_apartment
                                    };
                                    var api = new Api();
                                    var response = await api.addMember(data);

                                    //print(response);

                                    if(response['message']=='OK'){
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Home(widget.flatData)));
                                    }
                                  }
                                },
                              ),
                            ],
                          );
                        });
                      },
                    )
                  ]
                ),
              ),
            ),
            SizedBox(height: size.height*0.1,)
          ],
        ),
      ),
    );
  }
}