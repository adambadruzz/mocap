import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mocap/models/member_model.dart';
import 'package:mocap/view/detailpengurus_view.dart';
import 'package:mocap/viewmodel/pengurus_viewmodel.dart';
import 'package:mocap/viewmodel/navbar_viewmodel.dart';
import 'package:mocap/view/navbar_view.dart';

class PengurusView extends StatefulWidget {
  final int tahunSelesai;

  const PengurusView({Key? key, required this.tahunSelesai}) : super(key: key);

  @override
  _PengurusViewState createState() => _PengurusViewState();
}

class _PengurusViewState extends State<PengurusView> {
  final PengurusViewModel _pengurusViewModel = PengurusViewModel();
  final NavigationBarViewModel _navBarViewModel = NavigationBarViewModel();

  List<MemberModel> _memberMembers = [];
  List<MemberModel> _pengurus = [];

  @override
  void initState() {
    super.initState();
    _fetchPengurus();
    _fetchMembers();
  }

  Future<void> _fetchPengurus() async {
    final pengurus = await _pengurusViewModel.getMembersByRole(
      'Pengurus',
      widget.tahunSelesai
    );

    setState(() {
      _pengurus = pengurus;
    });
  }

   Future<void> _fetchMembers() async {
    final memberMembers = await _pengurusViewModel.getMembersByRole(
      'Member',
      widget.tahunSelesai
    );

    setState(() {
      _memberMembers = memberMembers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengurus List'),
      ),
      body: ListView(
        children: [
          const Divider(thickness: 3),
          if (_pengurus.isNotEmpty)
            const ListTile(
              title: Text('Pengurus'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: _pengurus.length,
            itemBuilder: (context, index) {
              final pengurus = _pengurus[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: pengurus.photourl.isNotEmpty
                      ? CachedNetworkImageProvider(pengurus.photourl) as ImageProvider<Object>?
                      : null,
                  child: pengurus.photourl.isEmpty ? const Icon(Icons.person, size: 40) : null,
                ),
                title: Text(pengurus.name),
                subtitle: Text(pengurus.email),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPengurusView(member: pengurus),
                    ),
                  );
                },
              );
            },
          ),
          const Divider(thickness: 3),
          if (_memberMembers.isNotEmpty)
            const ListTile(
              title: Text('Member'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: _memberMembers.length,
            itemBuilder: (context, index) {
              final member = _memberMembers[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: member.photourl.isNotEmpty
                      ? CachedNetworkImageProvider(member.photourl) as ImageProvider<Object>?
                      : null,
                  child: member.photourl.isEmpty ? const Icon(Icons.person, size: 40) : null,
                ),
                title: Text(member.name),
                subtitle: Text(member.email),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPengurusView(member: member),
                    ),
                  );
                },
              );
            },
          ),
          const Divider(thickness: 3),
          
        ],
      ),
      bottomNavigationBar: NavBarView(
        viewModel: _navBarViewModel,
      ),
    );
  }
}
