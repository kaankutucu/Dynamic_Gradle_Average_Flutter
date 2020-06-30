import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grade Average',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;
  List<Ders> tumDersler;
  var formKey = GlobalKey<FormState>();
  double ortalama = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Center(child: Text("Grade Average")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: uygulamaGovdesi(),
    );
  }

  uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(
              10,
              10,
              10,
              0,
            ),
//            color: Colors.pink.shade200,
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Ders Adi",
                      hintText: "Ders Adini Giriniz",
                      labelStyle: TextStyle(
                        fontSize: 18,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.length > 0) {
                        return null;
                      } else
                        return "Ders adi bos olamaz";
                    },
                    onSaved: (kaydedilecekDeger) {
                      dersAdi = kaydedilecekDeger;
                      setState(() {
                        tumDersler.add(
                          Ders(dersAdi, dersHarfDegeri, dersKredi),
                        );
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            items: dersKredileriItems(),
                            value: dersKredi,
                            onChanged: (secilenKredi) {
                              setState(() {
                                dersKredi = secilenKredi;
                              });
                            },
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 4,
                        ),
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                            items: dersHarfDegerleriItems(),
                            value: dersHarfDegeri,
                            onChanged: (secilenHarf) {
                              setState(
                                () {
                                  dersHarfDegeri = secilenHarf;
                                },
                              );
                            },
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 4,
                        ),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            decoration: BoxDecoration(
              border: BorderDirectional(
                top: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
            ),
            child: Center(child: Text("Ortalama: $ortalama")),
          ),
          Expanded(
            child: Container(
//                color: Colors.green.shade200,
                child: ListView.builder(
              itemBuilder: _listeElemanlariniOlustur,
              itemCount: tumDersler.length,
            )),
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKredileriItems() {
    List<DropdownMenuItem<int>> krediler = [];

    for (int i = 1; i <= 10; i++) {
      krediler.add(DropdownMenuItem<int>(
        value: i,
        child: Text(
          "$i Kredi",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ));
    }
    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleriItems() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "AA",
          style: TextStyle(fontSize: 30),
        ),
        value: 4,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "BA",
          style: TextStyle(fontSize: 30),
        ),
        value: 3.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "BB",
          style: TextStyle(fontSize: 30),
        ),
        value: 3,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "CB",
          style: TextStyle(fontSize: 30),
        ),
        value: 2.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "CC",
          style: TextStyle(fontSize: 30),
        ),
        value: 2,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "DC",
          style: TextStyle(fontSize: 30),
        ),
        value: 1.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "DD",
          style: TextStyle(fontSize: 30),
        ),
        value: 1,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "FF",
          style: TextStyle(fontSize: 30),
        ),
        value: 0,
      ),
    );

    return harfler;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text(tumDersler[index].ad),
        subtitle: Text(
          tumDersler[index].kredi.toString() +
              "kredi Not Deger: " +
              tumDersler[index].harfDegeri.toString(),
        ),
      ),
    );
  }
}

class Ders {
  String ad;
  double harfDegeri;
  int kredi;

  Ders(this.ad, this.harfDegeri, this.kredi);
}
