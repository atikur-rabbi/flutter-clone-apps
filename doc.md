Using a GitHub repo
To get started, you need to create a repository. Within this repository there are a few files that you can have.

dartpad_metadata.yaml (MANDATORY)
hint.txt (OPTIONAL)
main.dart (MANDATORY)
solution.dart (OPTIONAL)
test.dart (OPTIONAL)
If you want to have only one Dart file, all you need are the dartpad_metadata.yaml and main.dart files, but you have the freedom to use other Dart files, too. In my case, I wanted to create the main.dart file without having the runApp() method within it, so I use test.dart to run the application. My repo consists of 3 files:

dartpad_metadata.yaml
main.dart
test.dart
Note that test.dart doesn’t require any imports. This is because DartPad sees main.dart and test.dart as one single file. So, if I import the Material package within main.dart, it will be seen in test.dart once the DartPad instance is loaded up.

To load this folder into DartPad you need to know the following:

gh_owner: Owner of the GitHub account.
gh_repo: Name of the repo within the above account.
gh_path: Path to a dartpad_metadata.yaml file within the repo.
gh_ref: (optional) Branch to use when loading the file. Defaults to master.
In my case:

gh_owner: JoseAlba
gh_repo: flutter_code
gh_path: lib/dartpad
The gh_ref is not needed since I am using the master branch
This means if I want to load:

https://github.com/JoseAlba/flutter_code/blob/master/lib/dartpad/main.dart

The DartPad URL would be:

dartpad.dev/embed-flutter.html?gh_owner=JoseAlba&gh_repo=flutter_code&gh_path=lib/dartpad

To embed a flutter application into an iframe, specify the following:
<div style=”position:relative;padding-top:56.25%;”>
<iframe src=’https://dartpad.dev/embed-flutter.html?gh_owner=JoseAlba&gh_repo=flutter_code&gh_path=lib/dartpad&theme=dark&run=true&split=50' style=”position:absolute;top:0;left:0;width:100%;height:100%;”></iframe>
</div>
In Conclusion
DartPad is a powerful tool that helps you test, share, and embed your code into web pages. If you want to learn more. see the DartPad wiki.