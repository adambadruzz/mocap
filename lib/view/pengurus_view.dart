import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mocap/models/member_model.dart';
import 'package:mocap/view/detailpengurus_view.dart';
import 'package:mocap/viewmodel/pengurus_viewmodel.dart';

class PengurusView extends GetView<PengurusViewModel> {
  final int tahunSelesai;

  const PengurusView({Key? key, required this.tahunSelesai}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pengurusController = Get.find<PengurusViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengurus List'),
      ),
      body: ListView(
        children: [
          const Divider(thickness: 3),
          if (pengurusController.pengurus.isNotEmpty)
            const ListTile(
              title: Text('Pengurus'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: pengurusController.pengurus.length,
            itemBuilder: (context, index) {
              final pengurus = pengurusController.pengurus[index];
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
                  Get.to(() => DetailPengurusView(member: pengurus));
                },
              );
            },
          ),
          const Divider(thickness: 3),
          if (pengurusController.memberMembers.isNotEmpty)
            const ListTile(
              title: Text('Member'),
              dense: true,
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: pengurusController.memberMembers.length,
            itemBuilder: (context, index) {
              final member = pengurusController.memberMembers[index];
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
                  Get.to(() => DetailPengurusView(member: member));
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
