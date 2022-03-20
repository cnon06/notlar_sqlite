import 'Notlar.dart';
import 'VeritabaniYardimcisi.dart';


class Notlardao
{

  Future <List<Notlar>> tumNotlar () async
  {
    var db = await VeriTabaniYardimcisi.veriTabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM notlar");

    return List.generate(maps.length, (index){
      var satir = maps[index];
      return Notlar(satir["not_id"],satir["ders_adi"] , satir["not1"], satir["not2"]);
    });
  }



  Future <void> notEkle (String dersAdi, int not1, int not2) async
  {
    var db = await VeriTabaniYardimcisi.veriTabaniErisim();
   // List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM notlar");

    var bilgiler = Map<String,dynamic>();

    bilgiler["ders_adi"] = dersAdi;
    bilgiler["not1"] = not1;
    bilgiler["not2"] = not2;

    db.insert("notlar", bilgiler);
  }

  Future <void> notGuncelle (int not_id,String dersAdi, int not1, int not2) async
  {
    var db = await VeriTabaniYardimcisi.veriTabaniErisim();
    // List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM notlar");

    var bilgiler = Map<String,dynamic>();

    bilgiler["ders_adi"] = dersAdi;
    bilgiler["not1"] = not1;
    bilgiler["not2"] = not2;


    db.update("notlar", bilgiler,where: "not_id=?",whereArgs: [not_id]);
  }

  Future <void> notSil (int not_id) async
  {
    var db = await VeriTabaniYardimcisi.veriTabaniErisim();

    db.delete("notlar",where: "not_id=?",whereArgs: [not_id]);
  }



}
