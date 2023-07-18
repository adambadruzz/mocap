import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/member_model.dart';
import '../viewmodel/member_viewmodel.dart';
import 'detailmember_view.dart';

class MemberView extends GetWidget<MemberViewModel> {
  MemberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member List'),
      ),
      body: Obx(
        () => ListView(
          children: [
            if (controller.leaders.isNotEmpty)
              const ListTile(
                title: Text('Leader'),
                dense: true,
              ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: controller.leaders.length,
              itemBuilder: (context, index) {
                final leader = controller.leaders[index];
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
                    Get.to(() => DetailMemberView(member: leader));
                  },
                );
              },
            ),
            const Divider(thickness: 3),
            if (controller.coleaders.isNotEmpty)
              const ListTile(
                title: Text('Co-Leader'),
                dense: true,
              ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: controller.coleaders.length,
              itemBuilder: (context, index) {
                final coleader = controller.coleaders[index];
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
                    Get.to(() => DetailMemberView(member: coleader));
                  },
                );
              },
            ),
            const Divider(thickness: 3),
            // Tambahkan bagian lainnya sesuai dengan role dan data yang diinginkan
          ],
        ),
      ),
    );
  }
}
