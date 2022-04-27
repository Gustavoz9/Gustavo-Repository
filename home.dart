import 'dart:ffi';

import 'package:app1/Modulos/Pages/carteiras.dart';
import 'package:app1/Modulos/Pages/subpages/suppage.dart';
import 'package:app1/models/modelView.dart';
import 'package:app1/repositorio/repositorioMoedas.dart';
import 'package:app1/widgets/listView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:slidy/slidy.dart';

final pageViewController = PageController();
final repoMoedas = MoedaRepository.tabela;

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  bool show = true;
  visibility() {
    setState(() {
      show = !show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color.fromARGB(0, 187, 222, 251),
              child: Stack(
                children: [
                  Positioned(
                    top: 77,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      padding: EdgeInsets.all(2),
                      color: Color.fromARGB(0, 255, 0, 0),
                      alignment: Alignment.topLeft,
                      child: Stack(
                        children: [
                          Container(
                            child: Positioned(
                                top: 5,
                                left: 25,
                                child: EyeButton(
                                  onpressed: visibility,
                                  visibility: show,
                                )),
                            alignment: Alignment.topRight,
                          ),
                          Container(
                            child: Positioned(
                                top: 50, left: 25, child: arrownButton()),
                            alignment: Alignment.bottomRight,
                          ),
                          Positioned(
                              top: 5,
                              left: 25,
                              child: Text(
                                'Carteira',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 35,
                                ),
                              )),
                          Positioned(
                            top: 45,
                            left: 25,
                            child: show
                                ? Text('R\$ 1.000,00',
                                    style: TextStyle(
                                      fontSize: 30,
                                    ))
                                : Container(
                                    child: Container(),
                                  ),
                          ),
                          Positioned(
                              top: 85,
                              left: 25,
                              child: Text('+R\$ 100,00 (100% do CDI)',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black45))),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 230,
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 530,
                        color: Color.fromARGB(0, 255, 193, 7),
                        child: ListViewAPP(
                          listOn: repoMoedas,
                          onTapNav: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Subpage(name: "name")));
                          },
                          boxDecoration: BoxDecoration(
                            border: repoMoedas[moeda].porcento > 0
                                ? Border.all(
                                    width: 1,
                                    color: Color.fromARGB(131, 191, 255, 119))
                                : Border.all(
                                    width: 1,
                                    color: Color.fromARGB(131, 255, 119, 119)),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color.fromARGB(131, 191, 255, 119),
                          ),
                        ),
                      ))
                ],
              ))),
    );
  }
}

BoxDecoration boxDecoration1(double porcento) {
  return BoxDecoration(
    border: porcento > 0
        ? Border.all(width: 1, color: Color.fromARGB(131, 191, 255, 119))
        : Border.all(width: 1, color: Color.fromARGB(131, 255, 119, 119)),
    borderRadius: BorderRadius.all(Radius.circular(30)),
    color: Color.fromARGB(131, 191, 255, 119),
  );
}

bool isEyePressed = true;
// Widget eyeButton() => IconButton(
//       onPressed: () {
//         visibility();
//       },
//       icon: Icon(isEyePressed ? Icons.visibility_off : Icons.visibility_off),
//     );
Widget arrownButton() => IconButton(
    onPressed: () {
      isEyePressed = !isEyePressed;
    },
    icon: Icon(
      Icons.keyboard_arrow_right_outlined,
      color: Colors.black26,
    ));

class EyeButton extends StatelessWidget {
  final VoidCallback onpressed;
  final bool visibility;

  const EyeButton({Key? key, required this.onpressed, required this.visibility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onpressed();
      },
      icon: Icon(visibility ? Icons.visibility : Icons.visibility_off),
    );
  }
}
