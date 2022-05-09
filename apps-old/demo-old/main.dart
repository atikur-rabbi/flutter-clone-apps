import 'package:flutter/material.dart';
class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Creating a Dartpad with a repository!'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('gh_owner: Owner of the Github Account. In thise case is is: Jose Alba '),
            Text('gh_repo: Name of the repo within the above account. In this case it is: flutter_code'),
            Text('gh_path: Path to a dartpad_metadata.yaml file within the repo. In this case it is: lib/dartpad'),
            Text('Collectivaly to make a dartpad with this repository the URL would be: '),
            Text('dartpad.dev/embed-flutter.html?gh_owner=JoseAlba&gh_repo=flutter_code&gh_path=lib/dartpad'),
          ],
        ),
      ),
    );
  }
}