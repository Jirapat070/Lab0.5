import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formkey = GlobalKey<FormState>();
  final _stdidControler = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            Text("ชื่อ-นามสกุล",),
           
            
            TextFormField(
               controller: _stdidControler,
               validator: (value) {
                 if(value!.trim().isEmpty
        
                ){
                  return "กรุณากรอกชื่อ-นามสกุลนิสิต";
                
                }
                return null;
               },
            ),
            ElevatedButton(onPressed: (){
              if(_formkey.currentState!.validate()){

              }
            }, child: Text("Submit"))
          ],
        ),
      )
    );
  }
}