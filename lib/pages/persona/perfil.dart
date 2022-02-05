import 'package:arriendo/controller/controller_persona/controller_persona.dart';
import 'package:arriendo/controller/controller_solicitud_rol/controller_solicitud_rol.dart';
import 'package:arriendo/models/constantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPerfil extends StatefulWidget {
  @override
  _MyPerfilState createState() => new _MyPerfilState();
}

class _MyPerfilState extends State<MyPerfil> {
  ControllerPersona controller_persona = new ControllerPersona();
  ControllerSolicitudRol controller_solicitud_rol = new ControllerSolicitudRol();

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
          mainAxisAlignment: MainAxisAlignment.center,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Mi PERFIL",
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(45),
                        fontFamily: "Poppins-Bold",
                        fontWeight: FontWeight.bold,
                        letterSpacing: .6)),
              ],
            ),
            persona_rol==3?
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                          disabledColor: Colors.amber,
                          child: Text("Activar modo Arrendatario"),
                          splashColor: Colors.amber,
                          color: Colors.blue[100],
                          onPressed: () {
                            controller_solicitud_rol.insert_solicitud_rol(persona_id, context);
                          },
                        ),
              ],
            ):Text(''),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: persona_imagen == ""
                      ? NetworkImage(no_foto)
                      : NetworkImage(persona_imagen),
                  radius: 50.0,
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Nombre:",
                style: TextStyle(
                    fontFamily: "Poppins-Bold",
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text(persona_nombre,
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Apellido:",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text(persona_apellido,
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Direccion:",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text(persona_direccion,
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Telefono:",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text(persona_telefono,
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Correo:",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text(persona_correo,
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Usuario:",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text(persona_usuario,
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
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
                              onTap: () {
                                controller_persona
                                    .redireccionar_editar_perfil(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Editar Perfil",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 18,
                                          letterSpacing: 1.0)),
                                ],
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
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
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
