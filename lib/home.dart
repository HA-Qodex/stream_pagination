import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_pagination/provider.dart';
import 'package:stream_pagination/user_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {

  @override
  void didChangeDependencies() {
    ref.watch(userProvider).initiateData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            // print("${scrollInfo.metrics.maxScrollExtent}/${scrollInfo.metrics.pixels}");
            if ((scrollInfo.metrics.maxScrollExtent - scrollInfo.metrics.pixels) < 100 ) {
              provider.requestNextPage();
            }
            return true;
          },
          child: StreamBuilder<List<DocumentSnapshot>>(
              stream: provider.streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Text('Loading...');
                  default:
                    log("Items: ${snapshot.data!.length}");
                    var x = snapshot.data!.map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>)).toList();
                    return ListView.builder(
                        itemCount: x.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: ListTile(
                                title:
                                    Text(x[index].fullName.toString()),
                                trailing: Text(x[index].activeDonor.toString()),
                              ),
                            ));
                }
              }),
        ),
      ),
    );
  }
}
