import 'package:arriendo/controller/controller_galeria/controller_galeria.dart';
import 'package:flutter/material.dart';

class GaleriaFotosInmueble extends StatefulWidget {
  final List datos;
  final int id_dueno;
  GaleriaFotosInmueble({Key key, this.datos,this.id_dueno}) : super(key: key);
  @override
  _GaleriaFotosInmuebleState createState() => _GaleriaFotosInmuebleState();
}

class _GaleriaFotosInmuebleState extends State<GaleriaFotosInmueble> {
  ControllerGaleria controller_galeria = new ControllerGaleria();  
  @override
  void initState() {
    super.initState();
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GALERIA DE FOTOS'),
      ),
      body: widget.datos != null
          ? GridView.builder(
              itemCount: widget.datos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    controller_galeria.enviar_datos_foto_inmueble(
                        widget.id_dueno,
                        int.parse(widget.datos[index]['gal_id']),
                        int.parse(widget.datos[index]['gal_id_inmueble']),
                        widget.datos[index]['gal_imagen'],
                        context);

                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                    child:Image.network(
                        widget.datos[index]['gal_imagen'],
                        loadingBuilder: (context, child, loadingProgress) {
                          return loadingProgress==null ? child :  Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.grey) ,),);
                        },
                        fit: BoxFit.cover,                      
                    ),
                  ),
                );
              })
          : Text('No hay Datos'),
    );
  }
}
