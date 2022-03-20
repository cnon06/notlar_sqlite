

import 'package:flutter/material.dart';
import 'package:untitled1/Notlar.dart';
import 'package:untitled1/notlardao.dart';

import 'main.dart';

class NotDetaySayfa extends StatefulWidget {

  Notlar not;

  NotDetaySayfa({ required this.not});


  @override
  State<NotDetaySayfa> createState() => _NotDetaySayfaState();
}

class _NotDetaySayfaState extends State<NotDetaySayfa> {


  var tfDersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();


  Future<void> sil(int not_id) async
  {
    await Notlardao().notSil(not_id);
    print('Ders silindi');
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }


  Future<void> guncelle(int not_id,String dersAdi, int not1, int not2) async
  {
    await Notlardao().notGuncelle(not_id, dersAdi, not1, not2);
    print('Ders adı: $dersAdi, Not 1: $not1, Not 2: $not2 güncellendi.');
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tfDersAdi.text = widget.not.ders_adi;
    tfNot1.text = widget.not.not1.toString();
    tfNot2.text = widget.not.not2.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Detay"),
        actions: [
          TextButton(onPressed: ()
              {
                sil(widget.not.not_id);
              }, child: Text("Sil",style: TextStyle(color: Colors.white),)),

          TextButton(onPressed: ()
          {
            guncelle(widget.not.not_id, tfDersAdi.text, int.parse(tfNot1.text), int.parse(tfNot2.text));
          }, child: Text("Güncelle",style: TextStyle(color: Colors.white))),
        ],
      ),
      body: Center(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0,right: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                TextField(
                  controller: tfDersAdi,
                  decoration: InputDecoration(hintText: "Ders Adı"),

                ),

                TextField(
                  controller: tfNot1,
                  decoration: InputDecoration(hintText: "1. Not"),
                ),

                TextField(
                  controller: tfNot2,
                  decoration: InputDecoration(hintText: "2. Not"),
                ),


              ],
            ),
          ),
        ),
      ),



    );
  }
}
