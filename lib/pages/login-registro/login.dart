import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:arriendo/controller/controller_persona/controller_persona.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  ControllerPersona controller_persona = new ControllerPersona();
  TextEditingController usuario = new TextEditingController();
  TextEditingController password = new TextEditingController(); 
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
            Text("Login",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(50),
                    fontFamily: "Poppins-Bold",
                    fontWeight: FontWeight.bold,
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Usuario o correo",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(30))),
            TextField(
              controller: usuario,
              decoration: InputDecoration(
                  hintText: "Ingrese su usuario o su correo",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Clave",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().setSp(30))),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Ingrese su clave",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
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
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          )),
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
                                if (usuario.text != "" && password.text != "") {
                                  controller_persona.controller_login(
                                      usuario.text, password.text,true, context);
                                } else {
                                  aviso(
                                      "Ingrese Usuario y contrase??a", context);
                                }
                              },
                              child: Center(
                                child: Text("SIGNIN",
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
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Registrarse? ",
                        style: TextStyle(
                            fontFamily: "Poppins-Medium", fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          controller_persona.redirreccionar_registro(context);
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              color: Color(0xFF5d74e3),
                              fontFamily: "Poppins-Bold",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
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
}


