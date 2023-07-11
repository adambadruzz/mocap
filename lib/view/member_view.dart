import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/member_model.dart';
import '../services/auth_service.dart';
import '../viewmodel/drawer_viewmodel.dart';
import '../viewmodel/member_viewmodel.dart';
import 'detailmember_view.dart';
import 'drawer_view.dart';

class MemberView extends StatefulWidget {
  const MemberView({Key? key}) : super(key: key);

  @override
  State<MemberView> createState() => _MemberViewState();
}

class _MemberViewState extends State<MemberView> {
  final MemberViewModel _memberViewModel = MemberViewModel();
  List<MemberModel> _leaders = [];
  List<MemberModel> _coleaders = [];
  List<MemberModel> _secretary = [];
  List<MemberModel> _treasurer = [];
  List<MemberModel> _leadersEnd = [];
  List<MemberModel> _leadersUnD = [];
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
    final coleaders = await _memberViewModel.getMembersByRole('Co-Leader');
    final secretary = await _memberViewModel.getMembersByRole('Secretary');
    final treasurer = await _memberViewModel.getMembersByRole('Treasurer');
    final leadersEnD = await _memberViewModel.getMembersByRole('Leader Engineer & Developer');
    final leadersUnD = await _memberViewModel.getMembersByRole('Leader User Interface & Design');
    final endDivisionMembers =
        await _memberViewModel.getMembersByRole('Engineer & Developer');
    final undDivisionMembers =
        await _memberViewModel.getMembersByRole('User Interface & Design');
    final memberMembers = await _memberViewModel.getMembersByRole('Member');

    setState(() {
      _leaders = leaders;
      _coleaders = coleaders;
      _secretary = secretary;
      _treasurer = treasurer;
      _leadersEnd = leadersEnD;
      _leadersUnD = leadersUnD;
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
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: leader.photourl.isNotEmpty
                      ? CachedNetworkImageProvider(leader.photourl) as ImageProvider<Object>?
                      : null,
                  child: leader.photourl.isEmpty
                      ? Icon(Icons.person, size: 40)
                      : null,
                ),
                title: Text(leader.name),
                subtitle: Text(leader.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMemberView(member: leader),
                    ),
                  );
                },
              );
            },
          ),
          Divider(thickness: 3),
          if (_coleaders.isNotEmpty)
            ListTile(
              title: Text('Co-Leader'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _coleaders.length,
            itemBuilder: (context, index) {
              final coleader = _coleaders[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: coleader.photourl.isNotEmpty
                      ? CachedNetworkImageProvider(coleader.photourl) as ImageProvider<Object>?
                      : null,
                  child: coleader.photourl.isEmpty
                      ? Icon(Icons.person, size: 40)
                      : null,
                ),
                title: Text(coleader.name),
                subtitle: Text(coleader.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMemberView(member: coleader),
                    ),
                  );
                },
              );
            },
          ),
          Divider(thickness: 3),
          if (_secretary.isNotEmpty)
            ListTile(
              title: Text('Secretary'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _secretary.length,
            itemBuilder: (context, index) {
              final secretary = _secretary[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: secretary.photourl.isNotEmpty
                      ? CachedNetworkImageProvider(secretary.photourl) as ImageProvider<Object>?
                      : null,
                  child: secretary.photourl.isEmpty
                      ? Icon(Icons.person, size: 40)
                      : null,
                ),
                title: Text(secretary.name),
                subtitle: Text(secretary.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMemberView(member: secretary),
                    ),
                  );
                },
              );
            },
          ),
          Divider(thickness: 3),
          if (_treasurer.isNotEmpty)
            ListTile(
              title: Text('Treasurer'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _treasurer.length,
            itemBuilder: (context, index) {
              final treasurer = _treasurer[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: treasurer.photourl.isNotEmpty
                      ? CachedNetworkImageProvider(treasurer.photourl) as ImageProvider<Object>?
                      : null,
                  child: treasurer.photourl.isEmpty
                      ? Icon(Icons.person, size: 40)
                      : null,
                ),
                title: Text(treasurer.name),
                subtitle: Text(treasurer.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMemberView(member: treasurer),
                    ),
                  );
                },
              );
            },
          ),
          Divider(thickness: 3),
          if (_leadersEnd.isNotEmpty)
            ListTile(
              title: Text('Leader Engineer & Developer'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _leadersEnd.length,
            itemBuilder: (context, index) {
              final leaderEnd = _leadersEnd[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: leaderEnd.photourl.isNotEmpty
                      ? CachedNetworkImageProvider(leaderEnd.photourl) as ImageProvider<Object>?
                      : null,
                  child: leaderEnd.photourl.isEmpty
                      ? Icon(Icons.person, size: 40)
                      : null,
                ),
                title: Text(leaderEnd.name),
                subtitle: Text(leaderEnd.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMemberView(member: leaderEnd),
                    ),
                  );
                },
              );
            },
          ),
          Divider(thickness: 3),
          if (_leadersUnD.isNotEmpty)
            ListTile(
              title: Text('Leader User Interface & Design'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _leadersUnD.length,
            itemBuilder: (context, index) {
              final leaderUnD = _leadersUnD[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: leaderUnD.photourl.isNotEmpty
                      ? CachedNetworkImageProvider(leaderUnD.photourl) as ImageProvider<Object>?
                      : null,
                  child: leaderUnD.photourl.isEmpty
                      ? Icon(Icons.person, size: 40)
                      : null,
                ),
                title: Text(leaderUnD.name),
                subtitle: Text(leaderUnD.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMemberView(member: leaderUnD),
                    ),
                  );
                },
              );
            },
          ),
          Divider(thickness: 3),
          if (_endDivisionMembers.isNotEmpty)
            ListTile(
              title: Text('Engineer & Developer Division'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _endDivisionMembers.length,
            itemBuilder: (context, index) {
              final enddivision = _endDivisionMembers[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: enddivision.photourl.isNotEmpty
                      ? CachedNetworkImageProvider(enddivision.photourl) as ImageProvider<Object>?
                      : null,
                  child: enddivision.photourl.isEmpty
                      ? Icon(Icons.person, size: 40)
                      : null,
                ),
                title: Text(enddivision.name),
                subtitle: Text(enddivision.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMemberView(member: enddivision),
                    ),
                  );
                },
              );
            },
          ),
          Divider(thickness: 3),
          if (_undDivisionMembers.isNotEmpty)
            ListTile(
              title: Text('User Interface & Design Division'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: _undDivisionMembers.length,
            itemBuilder: (context, index) {
              final unddivision = _undDivisionMembers[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: unddivision.photourl.isNotEmpty
                      ? CachedNetworkImageProvider(unddivision.photourl) as ImageProvider<Object>?
                      : null,
                  child: unddivision.photourl.isEmpty
                      ? Icon(Icons.person, size: 40)
                      : null,
                ),
                title: Text(unddivision.name),
                subtitle: Text(unddivision.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMemberView(member: unddivision),
                    ),
                  );
                },
              );
            },
          ),
          Divider(thickness: 3),
          if (_memberMembers.isNotEmpty)
            ListTile(
              title: Text('Member'),
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
                  child: member.photourl.isEmpty
                      ? Icon(Icons.person, size: 40)
                      : null,
                ),
                title: Text(member.name),
                subtitle: Text(member.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMemberView(member: member),
                    ),
                  );
                },
              );
            },
          ),
          Divider(thickness: 3),
        ],
      ),
    );
  }
}
