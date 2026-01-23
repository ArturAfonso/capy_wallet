import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_lightning_controller.dart';

class HomeLightningView extends GetView<HomeLightningController> {
  const HomeLightningView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeLightningView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomeLightningView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
