import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_onchain_controller.dart';

class HomeOnchainView extends GetView<HomeOnchainController> {
  const HomeOnchainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeOnchainView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomeOnchainView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
