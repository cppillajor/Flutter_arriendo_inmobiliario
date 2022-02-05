import 'package:arriendo/controller/controller_inmueble/controller_inmueble.dart';
import 'package:arriendo/sidebar/drawer.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  final List datos;
  
  const HomeScreen({Key key, this.datos}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ControllerInmueble controller_inmueble = new ControllerInmueble();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      appBar: AppBar(
        title: Text('ARRIENDO DE INMOBILIARIA'),
      ),
      drawer: MainDrawer(),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Container(
                  child: Expanded(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text('EL QUINCHE TE OFRECE  ',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0)),
                      ],
                    ),
                  )),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50.0),
            child: Row(
              children: <Widget>[
                Container(
                  child: Expanded(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(                      
                      children: [    
                                                
                        SizedBox(width: 10.0, height: 100.0),                                              
                        DefaultTextStyle(
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0
                          ),
                          child: AnimatedTextKit(
                            pause: Duration(seconds: 2),
                            isRepeatingAnimation: true,
                            repeatForever: true,
                            stopPauseOnTap: false,
                            animatedTexts: [
                            ScaleAnimatedText('CUARTOS'),
                            ScaleAnimatedText('TERRENOS'),
                            ScaleAnimatedText('ENTRE OTROS'),
                            ],
                          
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ],
            ),
          ),
          
          //SizedBox(height: 10.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height - 300.0,
                        child: ListView.builder(
                            //scrollDirection: Axis.vertical,
                            itemCount: widget.datos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 10.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        controller_inmueble
                                            .enviar_datos_destinationscreen(
                                                int.parse(widget.datos[index]
                                                    ['tin_id']),
                                                "inmueble_segun_tipo_inmueble",
                                                context);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Container(
                                                  child: Row(children: [
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      widget.datos[index]
                                                          ['tin_imagen']),
                                                  radius: 80,
                                                ),
                                                SizedBox(width: 10.0),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          widget.datos[index]
                                                              ['tin_nombre'],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 30.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          widget.datos[index][
                                                              'tin_descripcion'],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontSize: 22.0,
                                                              color:
                                                                  Colors.grey))
                                                    ])
                                              ])),
                                            ),
                                          ),
                                        ],
                                      )));
                            }))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
