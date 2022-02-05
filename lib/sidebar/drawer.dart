import 'package:arriendo/controller/controller_enarriendo/controller_en_arriendo.dart';
import 'package:arriendo/controller/controller_inmueble/controller_inmueble.dart';
import 'package:arriendo/controller/controller_notificacion/controller_notificacion.dart';
import 'package:arriendo/controller/controller_persona/controller_persona.dart';
import 'package:arriendo/controller/controller_rol/controller_rol.dart';
import 'package:arriendo/controller/controller_solicitud_rol/controller_solicitud_rol.dart';
import 'package:arriendo/controller/controller_tipo_inmueble/controller_tipo_arriendo.dart';
import 'package:arriendo/models/constantes.dart';
import 'package:flutter/material.dart';
import 'package:arriendo/pages/persona/perfil.dart';

import 'menu_item.dart';

class MainDrawer extends StatefulWidget {
  MainDrawer({Key key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  ControllerInmueble controller_inmueble = new ControllerInmueble();
  ControllerTipoArriendo controller_tipo_arriendo =
      new ControllerTipoArriendo();
  ControllerPersona controller_persona = new ControllerPersona();
  ControllerNotificacion controller_notificacion = new ControllerNotificacion();
  ControllerRol controller_rol = new ControllerRol();
  ControllerEnArriendo controller_en_arriendo = new ControllerEnArriendo();
  ControllerSolicitudRol controller_solicitud_rol = new ControllerSolicitudRol();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: const Color(0xFF262AAA),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  ListTile(
                    title: Text(
                      persona_nombre + " " + persona_apellido,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(persona_imagen),
                      child: Icon(
                        Icons.perm_identity,
                        color: Colors.white,
                      ),
                      radius: 20,
                    ),
                  ),
                  Divider(
                    height: 64,
                    thickness: 0.5,
                    color: Colors.white.withOpacity(0.3),
                    indent: 32,
                    endIndent: 32,
                  ),

                  //Usuario
                  Row(
                    children: <Widget>[
                      Container(
                        child: Expanded(
                            child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: MenuItem(
                            icon: Icons.home,
                            title: "Home",
                            onTap: () {
                              controller_tipo_arriendo
                                  .enviar_datos_homescreen(context);
                            },
                          ),
                        )),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Expanded(
                            child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: MenuItem(
                            icon: Icons.person,
                            title: "Mi Perfil",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyPerfil()));
                            },
                          ),
                        )),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Expanded(
                            child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: MenuItem(
                            icon: Icons.notifications,
                            title: "Notificacion",
                            onTap: () {
                              controller_notificacion
                                  .visualizar_notificacion(context);
                            },
                          ),
                        )),
                      ),
                    ],
                  ),
                  //ARRENDATARIO
                  persona_rol == 1 || persona_rol == 2
                      ? Row(
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: MenuItem(
                                  icon: Icons.account_balance,
                                  title: "Mis Inmuebles",
                                  onTap: () {
                                    controller_inmueble
                                        .enviar_datos_destinationscreen(
                                            persona_id,
                                            "segun_id_persona",
                                            context);
                                  },
                                ),
                              )),
                            ),
                          ],
                        )
                      : Text(''),
                  persona_rol == 1 || persona_rol == 2
                      ? Row(
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: MenuItem(
                                  icon: Icons.add_circle_outline,
                                  title: "Ingresar Inmuebles",
                                  onTap: () {
                                    controller_inmueble
                                        .redireccionar_ingresar_inmueble(
                                            context);
                                  },
                                ),
                              )),
                            ),
                          ],
                        )
                      : Text(''),
                  persona_rol == 1 || persona_rol == 2
                      ? Row(
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: MenuItem(
                                  icon: Icons.business,
                                  title: "Visualizar Inmuebles Arrendados",
                                  onTap: () {
                                    controller_en_arriendo
                                        .visualizar_en_arriendo(context);
                                  },
                                ),
                              )),
                            ),
                          ],
                        )
                      : Text(''),

                  //ADMINISTRADOR
                  persona_rol == 1
                      ? Row(
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: MenuItem(
                                  icon: Icons.playlist_add,
                                  title: "Ingresar Tipo Inmuebles",
                                  onTap: () {
                                    controller_tipo_arriendo
                                        .redireccionar_ingresar_tipo_inmueble(
                                            context);
                                  },
                                ),
                              )),
                            ),
                          ],
                        )
                      : SizedBox(),
                  persona_rol == 1
                      ? Row(
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: MenuItem(
                                  icon: Icons.store_mall_directory,
                                  title: "Visualizar Tipo Inmuebles",
                                  onTap: () {
                                    controller_tipo_arriendo
                                        .enviar_datos_visualizar_tipo_inmueble(
                                            context);

                                  },
                                ),
                              )),
                            ),
                          ],
                        )
                      : SizedBox(),
                  persona_rol == 1
                      ? Row(
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: MenuItem(
                                  icon: Icons.supervisor_account,
                                  title: "Visualizar Todas las Persona",
                                  onTap: () {
                                    controller_persona
                                        .visualizar_todas_las_personas(context);
                                  },
                                ),
                              )),
                            ),
                          ],
                        )
                      : SizedBox(),
                  persona_rol == 1
                      ? Row(
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: MenuItem(
                                  icon: Icons.subject,
                                  title: "Visualizar Solicitud Arrendatario",
                                  onTap: () {
                                    controller_solicitud_rol.select_solicitud_rol(context);
                                  },
                                ),
                              )),
                            ),
                          ],
                        )
                      : SizedBox(),
                  persona_rol == 1
                      ? Row(
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                  child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: MenuItem(
                                  icon: Icons.settings,
                                  title: "Roles",
                                  onTap: () {
                                    controller_rol
                                        .redireccionar_visualizar_roles(
                                            context);
                                  },
                                ),
                              )),
                            ),
                          ],
                        )
                      : SizedBox(),
                  Divider(
                    height: 64,
                    thickness: 0.5,
                    color: Colors.white.withOpacity(0.3),
                    indent: 32,
                    endIndent: 32,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Expanded(
                            child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: MenuItem(
                            icon: Icons.exit_to_app,
                            title: "Logout",
                            onTap: () {
                              controller_persona.logout(context);
                            },
                          ),
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
