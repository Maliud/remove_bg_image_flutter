import 'package:http/http.dart' as http;

class Api {
  

  static const apiKey = '15uWd9ej6notZ515CMDmcGwH';

  static var baseUrl =  Uri.parse('https://api.remove.bg/v1.0/removebg');

  static removeBg(String imgPath) async {
    var req = http.MultipartRequest('POST', baseUrl);

    req.headers.addAll({'X-API-KEY': apiKey});

    req.files.add(await http.MultipartFile.fromPath('image_file', imgPath));

    final res = await req.send();
    print(res);

    if (res.statusCode == 200) {

      http.Response img = await http.Response.fromStream(res);
      return img.bodyBytes;
    }else{
      print("data girişinde hata oluştu!!");
      return null;
    }
  }

}