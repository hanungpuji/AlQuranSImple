// import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<DetailListSurah> fetchDetailListSurah(String surah) async {
  final response = await http
      .get(Uri.parse('https://equran.id/api/surat/${surah}'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    DetailListSurah responseJson = DetailListSurah.fromJson(json.decode(response.body));
    return responseJson;
    // return jsonDecode(response.body);


  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Surah');
  }
}
class DetailListSurah {
  final int nomor;
  final String nama;
  final String nama_latin;
  final int jumlah_ayat;
  final String tempat_turun;
  final String arti;
  final String deskripsi;
  final String audio;
  // final String status;
  final List ayat;
  // final String surat_selanjutnya;
  // final String surat_sebelumnya;

  const DetailListSurah({
    required this.nomor,
    required this.nama,
    required this.nama_latin,
    required this.jumlah_ayat,
    required this.tempat_turun,
    required this.arti,
    required this.deskripsi,
    required this.audio,
    // required this.status,
    required this.ayat,
    // required this.surat_selanjutnya,
    // required this.surat_sebelumnya,
  });

  factory DetailListSurah.fromJson(Map<String, dynamic> json) {
    return DetailListSurah(
      nomor: json['nomor'],
      nama: json['nama'],
      nama_latin: json['nama_latin'],
      jumlah_ayat: json['jumlah_ayat'],
      tempat_turun: json['tempat_turun'],
      arti: json['arti'],
      deskripsi: json['deskripsi'],
      audio: json['audio'],
      // status: json['status'],
      ayat:  json['ayat'].map((e) => DetailAyat.fromJson(e)).toList(),
      // surat_selanjutnya: json['surat_selanjutnya'],
      // surat_sebelumnya: json['surat_sebelumnya'],
    );
  }
}

class DetailAyat{
  final int id;
  final int surah;
  final int nomor;
  final String ar;
  final String tr;
  final String idn;

  const DetailAyat({
    required this.id,
    required this.surah,
    required this.nomor,
    required this.ar,
    required this.tr,
    required this.idn,
  });

  factory DetailAyat.fromJson(Map<String, dynamic> json) {
    return DetailAyat(
      id: json['id'],
      surah: json['surah'],
      nomor: json['nomor'],
      ar: json['ar'],
      tr: json['tr'],
      idn: json['idn'],
    );
  }
}

