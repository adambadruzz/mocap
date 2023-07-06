import 'package:flutter/material.dart';
import '../models/member_model.dart';
import '../services/auth_service.dart';
import '../viewmodel/drawer_viewmodel.dart';
import '../viewmodel/member_viewmodel.dart';
import 'drawer_view.dart';

class MemberView extends StatefulWidget {
  const MemberView({Key? key}) : super(key: key);

  @override
  State<MemberView> createState() => _MemberViewState();
}

class _MemberViewState extends State<MemberView> {
  final MemberViewModel _memberViewModel = MemberViewModel();
  List<MemberModel> _leaders = [];
  List<MemberModel> _endDivisionMembers = [];
  List<MemberModel> _undDivisionMembers = [];
  List<MemberModel> _memberMembers = [];

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  Future<void> _fetchMembers() async {
    final leaders = await _memberViewModel.getMembersByRole('Leader');
    final endDivisionMembers =
        await _memberViewModel.getMembersByRole('Engineer & Developer');
    final undDivisionMembers =
        await _memberViewModel.getMembersByRole('User Interface & Design');
    final memberMembers = await _memberViewModel.getMembersByRole('Member');

    setState(() {
      _leaders = leaders;
      _endDivisionMembers = endDivisionMembers;
      _undDivisionMembers = undDivisionMembers;
      _memberMembers = memberMembers;
    });
  }

  @override
  Widget build(BuildContext context) {
    final drawerViewModel = DrawerViewModel(
      authService: AuthService(),
      context: context,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Member List'),
      ),
      drawer: DrawerView(viewModel: drawerViewModel),
      body: ListView(
        children: [
          if (_leaders.isNotEmpty)
            ListTile(
              title: Text('Leader'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _leaders.length,
            itemBuilder: (context, index) {
              final leader = _leaders[index];
              return ListTile(
                title: Text(leader.name),
                subtitle: Text(leader.email),
              );
            },
          ),
          Divider(thickness: 3),
          if (_endDivisionMembers.isNotEmpty)
            ListTile(
              title: Text('End Division'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _endDivisionMembers.length,
            itemBuilder: (context,index) {
              final member = _endDivisionMembers[index];
              return ListTile(
                title: Text(member.name),
                subtitle: Text(member.email),
              );
            },
          ),
          Divider(thickness: 3),
          if (_undDivisionMembers.isNotEmpty)
            ListTile(
              title: Text('Und Division'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _undDivisionMembers.length,
            itemBuilder: (context, index) {
              final member = _undDivisionMembers[index];
              return ListTile(
                title: Text(member.name),
                subtitle: Text(member.email),
              );
            },
          ),
          Divider(thickness: 3),
          if (_memberMembers.isNotEmpty)
            ListTile(
              title: Text('Members'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _memberMembers.length,
            itemBuilder: (context, index) {
              final member = _memberMembers[index];
              return ListTile(
                title: Text(member.name),
                subtitle: Text(member.email),
              );
            },
          ),
          Divider(thickness: 3),
        ],
      ),
    );
  }
}
