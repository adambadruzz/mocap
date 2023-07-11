import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../models/member_model.dart';

class DetailMemberView extends StatelessWidget {
  final MemberModel member;

  const DetailMemberView({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: member.photourl.isNotEmpty
                    ? CachedNetworkImageProvider(member.photourl) as ImageProvider<Object>?
                    : null,
                child: member.photourl.isEmpty
                    ? Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: ListTile(
                title: Text('Name'),
                subtitle: Text(member.name),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Email'),
                subtitle: Text(member.email),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Date of Birth'),
                subtitle: Text(_formatDateOfBirth(member.dob) ?? 'N/A'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Phone'),
                subtitle: Text(member.phone ?? 'N/A'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Role'),
                subtitle: Text(member.role ?? 'N/A'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _formatDateOfBirth(DateTime? dateTime) {
    if (dateTime != null) {
      final formatter = DateFormat('dd MMM yyyy');
      return formatter.format(dateTime);
    }
    return null;
  }
}
