import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class VistaMapa extends StatefulWidget {
  final double latitud;
  final double longitud;
  final String telefono;
  VistaMapa({Key key, this.latitud, this.longitud,this.telefono}) : super(key: key);
  @override
  _VistaMapaState createState() => _VistaMapaState();
}

class _VistaMapaState extends State<VistaMapa> {  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Ubicacion del Inmueble'),
      ),
      body: Stack(
        children: <Widget>[
          new FlutterMap(
              options: new MapOptions(
                  zoom: 13.0,
                  center: new LatLng(widget.latitud, widget.longitud)),
              layers: [
                new TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c']),
                new MarkerLayerOptions(markers: [
                  new Marker(
                      
                      width: 70.0,
                      height: 70.0,
                      point: new LatLng(widget.latitud, widget.longitud),
                      builder: (context) => new Container(

                            child: Stack(
                              children: <Widget>[
                                DefaultTextStyle(
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.redAccent,
                                    fontFamily: 'Montserrat',
                                    
                                  ),
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      WavyAnimatedText('Click Aqui!'),
                                    ],
                                    isRepeatingAnimation: true,
                                    onTap: () {
                                      print("Tap Event");
                                    },
                                  ),
                                ),
                                IconButton(
                                  
                                  icon: Icon(Icons.location_on),
                                  onPressed: () {
                                    if(widget.telefono!=null){
                                      showllamada(context,widget.telefono); 
                                    }else{
                                      aviso('No hay telefono', context);
                                    }                                                                   
                                  }),
                              ],
                            ),
                          ))
                ])
              ])
        ],
      ),
    );
  }
}


void  showllamada(BuildContext context,String telefono) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF737373),
            child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30),
              topRight: const Radius.circular(30),
            )),
            child: Container(
              height: MediaQuery.of(context).size.height/5,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Container(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('INFORMACION'),
                            ],
                          ),
                          )

                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Container(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(width: 20,),
                                Text('TELEFONO: '),
                                SizedBox(width: 30,),
                                Text(telefono),
                                SizedBox(width: 30,),
                                IconButton(
                                    icon: Icon(Icons.phone),
                                    iconSize: 30.0,
                                    color: Colors.green,
                                    onPressed: () async{                                      
                                      FlutterPhoneDirectCaller.callNumber(telefono);
                                    },
                                ),
                              ],
                            )
                            )
                          ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
void aviso(String text, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text(text),
                  ],
                ),
              ),
            ],
          );
        });
  }