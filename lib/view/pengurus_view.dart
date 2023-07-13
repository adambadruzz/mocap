import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mocap/models/member_model.dart';
import 'package:mocap/view/detailmember_view.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  Future<void> _fetchMembers() async {
    final memberMembers = await _pengurusViewModel.getMembersByRole(
      'Pengurus',
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
        title: Text('Pengurus List'),
      ),
      body: ListView(
        children: [
          Divider(thickness: 3),
          if (_memberMembers.isNotEmpty)
            ListTile(
              title: Text('Pengurus'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _memberMembers.length,
            itemBuilder: (context, index) {
              final member = _memberMembers[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: member.photourl.isNotEmpty
                      ? CachedNetworkImageProvider(member.photourl) as ImageProvider<Object>?
                      : null,
                  child: member.photourl.isEmpty ? Icon(Icons.person, size: 40) : null,
                ),
                title: Text(member.name),
                subtitle: Text(member.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPengurusView(member: member),
                    ),
                  );
                },
              );
            },
          ),
          Divider(thickness: 3),
        ],
      ),
      bottomNavigationBar: NavBarView(
        viewModel: _navBarViewModel,
      ),
    );
  }
}
