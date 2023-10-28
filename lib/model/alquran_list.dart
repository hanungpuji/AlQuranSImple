// import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<ListSurah>> fetchListSurah() async {
  final response = await http
      .get(Uri.parse('https://equran.id/api/surat'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => ListSurah.fromJson(e)).toList();

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Surah');
  }
}
class ListSurah {
  final int nomor;
  final String nama;
  final String nama_latin;
  final int jumlah_ayat;
  final String tempat_turun;
  final String arti;
  final String deskripsi;

  const ListSurah({
    required this.nomor,
    required this.nama,
    required this.nama_latin,
    required this.jumlah_ayat,
    required this.tempat_turun,
    required this.arti,
    required this.deskripsi,
  });

  factory ListSurah.fromJson(Map<String, dynamic> json) {
    return ListSurah(
      nomor: json['nomor'],
      nama: json['nama'],
      nama_latin: json['nama_latin'],
      jumlah_ayat: json['jumlah_ayat'],
      tempat_turun: json['tempat_turun'],
      arti: json['arti'],
      deskripsi: json['deskripsi'],
    );
  }
}

