import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_incoming_call/flutter_incoming_call.dart';
import 'package:uuid/uuid.dart';
// import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class callScreen extends StatefulWidget {
  String num;

  callScreen(this.num);
  
  //const callScreen({Key? key}) : super(key: key); 

  
  @override
  _MyAppState createState() => _MyAppState();
}

 

class _MyAppState extends State<callScreen> { 

  String _name = '';
  String _handle = '';
  String _enterprise = '';

  void getData() async {
    var res = await _getListado();
    _name = res['name'];
    _handle = res['offer'];
    _enterprise = res['enterprise'];   
  }

  Future<dynamic> _getListado() async {
    String url = "https://us-central1-seleccion-qa.cloudfunctions.net/getNumberphone?phone=" + widget.num;
    final respuesta = await http.get(Uri.parse(url));
    
    if (respuesta.statusCode == 200){
      final response = jsonDecode(respuesta.body);
      print(jsonDecode(respuesta.body)) ;

      return response;
    } else {
      print("Error con la respuesta");
    }
  }

  var uuid = Uuid();

  BaseCallEvent? _lastEvent;
  CallEvent? _lastCallEvent;
  HoldEvent? _lastHoldEvent;
  MuteEvent? _lastMuteEvent;
  DmtfEvent? _lastDmtfEvent;
  AudioSessionEvent? _lastAudioSessionEvent;

  void _incomingCall() {
    
    final uid = uuid.v4();
    final name = _name;
    final avatar = _enterprise;
    final handle = _handle;
    final type = HandleType.generic;
    final isVideo = true;
    FlutterIncomingCall.displayIncomingCall(uid, name, avatar, handle, type, isVideo);
  }

  void _endCurrentCall() {
    if(_lastEvent != null) {
      FlutterIncomingCall.endCall(_lastCallEvent!.uuid);
    }
  }

  void _endAllCalls() {
    FlutterIncomingCall.endAllCalls();
  }

  @override
  
  void initState() {
    // _getListado();
    
    super.initState();
    getData();
    FlutterIncomingCall.configure(
      appName: 'example_incoming_call',
      duration: 30000,
      android: ConfigAndroid(
        vibration: true,
        ringtonePath: 'default',
        channelId: 'calls',
        channelName: 'Calls channel name',
        channelDescription: 'Calls channel description',
      ),
      ios: ConfigIOS(
        iconName: 'AppIcon40x40',
        ringtonePath: null,
        includesCallsInRecents: false,
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
      )
    );

    FlutterIncomingCall.onEvent.listen((event) {
    if(event is CallEvent) { // Android | IOS
    } else if(event is HoldEvent) { // IOS
    } else if(event is MuteEvent) { // IOS
    } else if(event is DmtfEvent) { // IOS
    } else if(event is AudioSessionEvent) { // IOS
    }
});
  }

  @override
  void dispose() {
    _endAllCalls();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                child: Text('Incoming call now'),
                onPressed: _incomingCall,
              ),
              SizedBox(height: 16),
              TextButton(
                child: Text('Incoming call delay 5 sec'),
                onPressed: () => Future.delayed(Duration(seconds: 5), _incomingCall),
              ),
              SizedBox(height: 16),
              TextButton(
                child: Text('End current call'),
                onPressed: _endCurrentCall,
              ),
              SizedBox(height: 16),
              TextButton(
                child: Text('End all calls'),
                onPressed: () {
                  _endAllCalls();
                  showDialog(
                    context: context, 
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(_enterprise),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text(_handle),
                                Text('¿Estas interesado?'),
                              ],
                            ),
                          ),
                          actions: [
                            FlatButton(
                              child: Text('SI'),
                              onPressed: () {
                                Navigator.of(context).pop();

                                showDialog(context: context, builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text('Gracias por aceptar nuestra oferta, en breve nos comunicaremos para mas información'),
                                    actions: [
                                      FlatButton(
                                        child: Text('Aceptar'),
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });

                              },
                            ),
                            FlatButton(
                              child: Text('NO'),
                              onPressed: () {
                                  Navigator.of(context).pop();
                              },
                            ),

                          ],
                        );
                    }
                    );
                }
                // _endAllCalls,
              ),
              SizedBox(height: 16),
              Text(
                'Last event:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _lastEvent != null ? _lastEvent.toString() : 'Not event',
                style: TextStyle(
                    fontSize: 16
                ),
              ),
              if(_lastCallEvent != null) ...[
                Text(
                  'Last call event:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _lastCallEvent.toString(),
                  style: TextStyle(
                      fontSize: 16
                  ),
                )
              ],
              if(_lastHoldEvent != null) ...[
                Text(
                  'Last hold event:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _lastHoldEvent.toString(),
                  style: TextStyle(
                      fontSize: 16
                  ),
                )
              ],
              if(_lastMuteEvent != null) ...[
                Text(
                  'Last mute event:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _lastMuteEvent.toString(),
                  style: TextStyle(
                      fontSize: 16
                  ),
                )
              ],
              if(_lastDmtfEvent != null) ...[
                Text(
                  'Last dmtf event:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _lastDmtfEvent.toString(),
                  style: TextStyle(
                      fontSize: 16
                  ),
                )
              ],
              if(_lastAudioSessionEvent != null) ...[
                Text(
                  'Last audio session event:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _lastAudioSessionEvent.toString(),
                  style: TextStyle(
                      fontSize: 16
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

