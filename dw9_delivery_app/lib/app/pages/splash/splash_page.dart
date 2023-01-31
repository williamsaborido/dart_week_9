import 'package:flutter/material.dart';

import '../../core/config/env/env.dart';
import '../../core/ui/widgets/delivery_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Teste'),
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text('Teste de label'),
              ),
            ),
            DeliveryButton(
              width: 400,
              height: 100,
              label: Env.instance['backend_base_url'] ?? '',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
