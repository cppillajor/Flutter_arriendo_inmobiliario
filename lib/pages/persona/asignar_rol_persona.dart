import 'package:arriendo/controller/controller_persona/controller_persona.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AsignarRolPersona extends StatefulWidget {
  final List datos_rol;
  final String nombre_apellido;
  final int id_persona;

  const AsignarRolPersona(
      {Key key, this.datos_rol, this.nombre_apellido, this.id_persona})
      : super(key: key);
  @override
  _AsignarRolPersonaState createState() => new _AsignarRolPersonaState();
}

class _AsignarRolPersonaState extends State<AsignarRolPersona> {
  ControllerPersona controller_persona = new ControllerPersona();
  String rol_nombre;
  int rol_id;

  Widget formCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.black,
                ),
                Text('REGRESAR'),
              ],
            ),
            Text("Asignar Rol al usuario",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(45),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("NOMBRE: ",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            Text(widget.nombre_apellido,
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    //fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Seleccione Rol:",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(8)),
              child: DropdownButton(
                hint: Text('Seleccione Rol'),
                dropdownColor: Colors.grey,
                elevation: 5,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36.0,
                isExpanded: true,
                value: rol_nombre,
                onChanged: (value) {
                  setState(() {
                    rol_nombre = value;
                    rol_id = int.parse(value);
                  });
                },
                items: widget.datos_rol.map((value) {
                  return DropdownMenuItem(
                    value: value['rol_id'],
                    child: Text(value['rol_nombre']),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/images/image_01.png"),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(child: Image.asset("assets/images/image_02.png"))
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Expanded(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("ARRIENDO INMOBILIARIA",
                                        style: TextStyle(
                                            fontFamily: "Poppins-Bold",
                                            fontSize: ScreenUtil.getInstance()
                                                .setSp(50),
                                            letterSpacing: .6,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  formCard(),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.red,
                              onTap: () {
                                controller_persona.editar_rol_persona(
                                    rol_id, widget.id_persona, context);
                                
                              },
                              child: Center(
                                child: Text("Asignar Rol",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
