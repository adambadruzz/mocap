
class MemberModel {
  final String id;
  final String name;
  final String email;
  final DateTime dob;
  final String asal;
  final String phone;
  final String role;
  final String roles;
  final String angkatan;
  final List<int> tahunkepengurusan;
  final String photourl;
  final String instagram;
  final String github;
  final String linkedin;

  MemberModel({
    required this.id,
    required this.name,
    required this.email,
    required this.dob,
    required this.phone,
    required this.role,
    required this.roles,
    required this.asal,
    required this.angkatan,
    required this.tahunkepengurusan,
    required this.photourl,
    required this.instagram,
    required this.github,
    required this.linkedin,
  });
}
