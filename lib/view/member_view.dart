import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/member_model.dart';
import '../viewmodel/member_viewmodel.dart';
import 'detailmember_view.dart';

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
    final int tahun = DateTime.now().year;
    //final int tahun = DateTime.now().year;
    //final int tahun2 = tahun+1;
    //untuk pengurus selanjutnya
    final leaders = await _memberViewModel.getMembersByRole('Leader', tahun);
    final coleaders = await _memberViewModel.getMembersByRole('Co-Leader', tahun);
    final secretary = await _memberViewModel.getMembersByRole('Secretary', tahun);
    final treasurer = await _memberViewModel.getMembersByRole('Treasurer', tahun);
    final leadersEnD = await _memberViewModel.getMembersByRole('Leader Engineer & Developer', tahun);
    final leadersUnD = await _memberViewModel.getMembersByRole('Leader User Interface & Design', tahun);
    final endDivisionMembers =
        await _memberViewModel.getMembersByRole('Engineer & Developer', tahun);
    final undDivisionMembers =
        await _memberViewModel.getMembersByRole('User Interface & Design', tahun);
    final memberMembers = await _memberViewModel.getMembersByRole('Member', tahun);


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
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member List'),
      ),
      body: ListView(
        children: [
          if (_leaders.isNotEmpty)
            const ListTile(
              title: Text('Leader'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
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
                      ? const Icon(Icons.person, size: 40)
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
          const Divider(thickness: 3),
          if (_coleaders.isNotEmpty)
            const ListTile(
              title: Text('Co-Leader'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
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
                      ? const Icon(Icons.person, size: 40)
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
          const Divider(thickness: 3),
          if (_secretary.isNotEmpty)
            const ListTile(
              title: Text('Secretary'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
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
                      ? const Icon(Icons.person, size: 40)
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
          const Divider(thickness: 3),
          if (_treasurer.isNotEmpty)
            const ListTile(
              title: Text('Treasurer'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
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
                      ? const Icon(Icons.person, size: 40)
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
          const Divider(thickness: 3),
          if (_leadersEnd.isNotEmpty)
            const ListTile(
              title: Text('Leader Engineer & Developer'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
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
                      ? const Icon(Icons.person, size: 40)
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
          const Divider(thickness: 3),
          if (_leadersUnD.isNotEmpty)
            const ListTile(
              title: Text('Leader User Interface & Design'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
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
                      ? const Icon(Icons.person, size: 40)
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
          const Divider(thickness: 3),
          if (_endDivisionMembers.isNotEmpty)
            const ListTile(
              title: Text('Engineer & Developer Division'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
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
                      ? const Icon(Icons.person, size: 40)
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
          const Divider(thickness: 3),
          if (_undDivisionMembers.isNotEmpty)
            const ListTile(
              title: Text('User Interface & Design Division'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
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
                      ? const Icon(Icons.person, size: 40)
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
                  child: member.photourl.isEmpty
                      ? const Icon(Icons.person, size: 40)
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
          const Divider(thickness: 3),
        ],
      ),
      
    );
  }
}
