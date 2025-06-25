class Ayat {
  final int aid;
  final int surahNo;
  final int ayahNo;
  final int cid;

  Ayat({
    required this.aid,
    required this.surahNo,
    required this.ayahNo,
    required this.cid,
  });

  factory Ayat.fromMap(Map<String, dynamic> json) => Ayat(
    aid: int.parse(json['aid'].toString()),
    surahNo: int.parse(json['surahNo'].toString()),
    ayahNo: int.parse(json['ayahNo'].toString()),
    cid: int.parse(json['cid'].toString()),
  );

  Map<String, dynamic> toMap() => {
    'aid': aid,
    'surahNo': surahNo,
    'ayahNo': ayahNo,
    'cid': cid,
  };
}
