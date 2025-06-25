class Clusters{
  final int cid;
  final String cname;

  Clusters({required this.cid,required this.cname});

  factory Clusters.fromMap(Map<String, dynamic> json) => Clusters(
    cid: int.parse(json['cid'].toString()),
    cname: json['cname'],
  );

  Map<String, dynamic> toMap() => {
    'cid': cid,
    'cname':cname
  };
}