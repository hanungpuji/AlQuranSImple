import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alquran/model/alquran_detaillist.dart';

class DetailScreen extends StatelessWidget{
  final String surah;
  final String nama_surah;

  const DetailScreen({Key? key, required this.surah, required this.nama_surah}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // if (constraints.maxWidth > 800) {
        //   return DetailMobilePage(surah: surah);
        // } else {
          return DetailMobilePage(surah: surah, nama_surah: nama_surah);
        // }
      },
    );
  }
}


class DetailMobilePage extends StatelessWidget{
  final String surah;
  final String nama_surah;

  const DetailMobilePage({Key? key, required this.surah, required this.nama_surah}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(nama_surah),
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: fetchDetailListSurah(surah),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.jumlah_ayat,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Container(decoration: BoxDecoration(
                            border: Border(bottom: BorderSide())),
                            child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: const Color(0xff6ae792),
                                  child: Text(
                                    snapshot.data!.ayat[index].nomor.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      snapshot.data!.ayat[index].ar.toString(),
                                      style: (
                                          TextStyle(
                                            fontSize: 28,
                                          )
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    Text(
                                      snapshot.data!.ayat[index].tr.toString(),
                                    ),
                                    Text(
                                      snapshot.data!.ayat[index].idn.toString(),
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
        )
    );
  }
}