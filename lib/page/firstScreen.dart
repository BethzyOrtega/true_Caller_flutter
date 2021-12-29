import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/page/secondScreen.dart';

class FirstScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      backgroundColor: Color.fromARGB(255, 21, 219, 203),
      body: Column(        
        children: <Widget> [
          Container(
            child: Text('Bienvenidos a TrueCaller',  textAlign: TextAlign.center,
            style: GoogleFonts.lato(
           textStyle: TextStyle(color: Color.fromARGB(255, 32, 32, 32), fontSize: 40, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700,),
            ),
            ),
            padding: EdgeInsets.fromLTRB(50, 140, 50, 130),
            
          ),
          Container(child: Text('Identifica quien te llama y liberate de llamadas innecesarias',textAlign: TextAlign.center,
            style: GoogleFonts.lato(
           textStyle: TextStyle(color: Color.fromARGB(255, 43, 42, 42), fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700,),
            ),
            ),
            padding: EdgeInsets.fromLTRB(50, 0, 50, 130),
            ),
          Container(
            // ignore: deprecated_member_use
            child: RaisedButton(
               child: Text("Continuar", style: TextStyle(fontSize: 25), ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => secondScreen(),
                )),
                color: Color.fromARGB(255, 225, 238, 43),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              
            )
          )           
        ],
      ),
      


    );
  }

}