import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/page/callScreen.dart';

class secondScreen extends StatelessWidget{
  final number = TextEditingController();
  String num = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      backgroundColor: Color.fromARGB(255, 21, 219, 203),
      body: Column(        
        children: <Widget> [
          Container(
            child: Text('Ingresa el numero a validar',textAlign: TextAlign.center,
            style: GoogleFonts.lato(
           textStyle: TextStyle(color: Color.fromARGB(255, 32, 32, 32), fontSize: 35, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700,),
            ),
            ),
            padding: EdgeInsets.fromLTRB(50, 140, 50, 60),            
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: TextField(
              controller: number,
              decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Ingrese numero:',
              hintText: 'Example: 51999999999',
              ),                
            ),
            
          ),
           Container(
            // ignore: deprecated_member_use
            child: RaisedButton(
               child: Text("Verificar", textAlign: TextAlign.center,
            style: GoogleFonts.lato(
           textStyle: TextStyle(color: Color.fromARGB(255, 32, 32, 32), fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700,),
            ),
            ),
                onPressed: (){
                  num = number.text;

                  if(num == '') {
                    print('ingrese numero');
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => callScreen(num)

                ));
                  }

                },
                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Color.fromARGB(255, 225, 238, 43),
              
            )
          )
           
        ],
      ),
      


    );
  }

}