import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

class Base64Utils {
  Base64Utils._();

  static String uint8List2Base64(Uint8List uint8list) {
    String base64 = base64Encode(uint8list);
    return base64;
  }

  static Future<ui.Image> base64ToImage(String data, {width, height}) async {
    Uint8List bytes = base64Decode(data);
    ui.Codec codec = await ui.instantiateImageCodec(bytes,
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  static Uint8List base64ToBytes(String data) {
    return base64Decode(data);
  }
}
