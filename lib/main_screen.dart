import 'package:flutter/material.dart';
import 'package:alquran/model/alquran_list.dart';
import 'package:alquran/detail_screen.dart';

class SurahScreen extends StatefulWidget {
  const SurahScreen({super.key});

  @override
  State<SurahScreen> createState() => _SurahScreen();
}

class _SurahScreen extends State<SurahScreen> {
  late Future<List<ListSurah>> futureListSurah;

  @override
  void initState() {
    super.initState();
    futureListSurah = fetchListSurah() as Future<List<ListSurah>>;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<ListSurah>>(
        future: fetchListSurah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return DetailScreen(surah: snapshot.data![index].nomor.toString(), nama_surah: snapshot.data![index].nama_latin);
                        }));
                      },
                    child: Container(decoration: BoxDecoration(
                        border: Border(bottom: BorderSide())),
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xff6ae792),
                              child: Text(
                                snapshot.data![index].nomor.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  snapshot.data![index].nama.toString(),
                                  style: (
                                      TextStyle(
                                        fontSize: 40,
                                      )
                                  ),
                                ),
                                Text(
                                    '${snapshot.data![index].nama_latin
                                        .toString()} (${snapshot.data![index].arti
                                        .toString()}) ${snapshot.data![index]
                                        .jumlah_ayat.toString()} Ayat'
                                ),
                                Text(
                                  snapshot.data![index].deskripsi.toString()
                                      .replaceAll(
                                      RegExp(r'<[^>]*>|&[^;]+;'), ' '),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            )
                        )
                      // You can display other properties as needed
                    ),
                  );
                },
              );
            } else {
              return Text('No data available');
            }
          }
        },
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Al-Quran Simple'),
        ),
        body: SafeArea(
          child: const SurahScreen(),
        )
      );
  }
}