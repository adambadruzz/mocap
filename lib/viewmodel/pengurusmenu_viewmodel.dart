import 'package:get/get.dart';

class PengurusMenuViewModel extends GetxController {
  List<String> generateTahunKepengurusan() {
    final int tahunSekarang = DateTime.now().year;
    final List<String> tahunKepengurusan = [];

    for (int tahun = 2019; tahun <= tahunSekarang; tahun++) {
      final String tahunMulai = tahun.toString();
      final String tahunSelesai = (tahun + 1).toString();
      tahunKepengurusan.add('$tahunMulai-$tahunSelesai');
    }

    return tahunKepengurusan;
  }

  int getTahunMulai(String tahunKepengurusan) {
    final List<String> tahun = tahunKepengurusan.split('-');
    return int.parse(tahun[0]);
  }

  int getTahunSelesai(String tahunKepengurusan) {
    final List<String> tahun = tahunKepengurusan.split('-');
    return int.parse(tahun[1]);
  }
}
