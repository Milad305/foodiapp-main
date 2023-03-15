import 'package:url_launcher/url_launcher.dart';

void LaunchUrl(url) async {
  var uri = Uri.parse(url.toString());
  if (!await launchUrl(
      Uri.https(
        uri.host.toString(),
        uri.path.toString(),
        uri.queryParametersAll,
      ),
      mode: LaunchMode.externalNonBrowserApplication))
    throw 'Could not launch $url';
}

void LaunchUrlExternal(url) async {
  var uri = Uri.parse(url.toString());
  if (!await launchUrl(
      Uri.https(
        uri.host.toString(),
        uri.path.toString(),
        uri.queryParametersAll,
      ),
      mode: LaunchMode.externalApplication)) throw 'Could not launch $url';
}
