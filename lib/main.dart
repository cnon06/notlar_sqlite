import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled1/Notlar.dart';
import 'package:untitled1/notlardao.dart';

import 'NotDetaySayfa.dart';
import 'NotKayitSayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {


  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {



  Future <List<Notlar>> tumNotlariGoster() async
  {



    /*
      var notlarListesi = <Notlar> [];
    notlarListesi.add(Notlar(1,"Tarih",100,70));
    notlarListesi.add(Notlar(2,"Kimya",90,80));
    notlarListesi.add(Notlar(3,"Fizik",70,75));
     */


    var notlarListesi = await Notlardao().tumNotlar();


    return notlarListesi;
  }

  Future<void> uygulamayiKapat() async
  {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: ()
          {
            uygulamayiKapat();
          },

        ),
        title:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notlar Uygulaması", style: TextStyle(color: Colors.white, fontSize: 16),),
            FutureBuilder<List<Notlar>>(
              future:  tumNotlariGoster(),
              builder: (context,snaphot)
              {
                double ortalama=0.0;
                if(snaphot.hasData)
                {
                  var notListesi = snaphot.data;

                  if(!notListesi!.isEmpty)
                    {
                      double toplam = 0.0;
                      for(var n in notListesi)
                      {
                        toplam += (n.not1+n.not2)/2;
                      }

                      ortalama = toplam/notListesi.length;
                    }




                  return Text("Ortalama: ${ortalama.toInt()}", style: TextStyle(color: Colors.white, fontSize: 14),);
                }
                else return Text("Ortalama: 0", style: TextStyle(color: Colors.white, fontSize: 14),);
              },

            ),
          ],


        ),



      ),
      body:WillPopScope(
        onWillPop: ()
        {
          return exit(0);
        },
        child: FutureBuilder<List<Notlar>>(
          future:  tumNotlariGoster(),
          builder: (context,snaphot)
          {

            if(snaphot.hasData)
            {
              var notListesi = snaphot.data;
              return ListView.builder(
                  itemCount:notListesi!.length,
                  itemBuilder: (context,indeks)
                  {
                    var notlar = notListesi[indeks];
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NotDetaySayfa(not: notlar)));
                      },
                      child: SizedBox(
                        height: 60,
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(notlar.ders_adi, style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("${notlar.not1}"),
                              Text("${notlar.not2}"),

                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            else return Center();
          },

        ),
      ),



      floatingActionButton: FloatingActionButton(
        tooltip: "Not Ekle",
        child: Icon(Icons.add),
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NotKayitSayfa()));
        },

      ),

    );
  }
}
