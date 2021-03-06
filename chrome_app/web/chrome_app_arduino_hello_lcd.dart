import 'dart:html';
import 'package:chrome/chrome_app.dart' as chrome;

final int MAX_LENGTH = 32;

InputElement input = querySelector('#txt');
SpanElement charLeft = querySelector('#left');
ButtonElement btn = querySelector('#btn');

void main() {

  // Sets input.maxLength to `MAX_LENGTH' and shows the count of remaining
  // characters.
  input
    ..maxLength = MAX_LENGTH
    ..onKeyUp.listen((e) {
      charLeft.text = (MAX_LENGTH - input.value.length).toString();
    });

  // Registers a callback to `onClick` event of DOM element with id 'btn'
  btn.onClick.listen((e) {
    // Selects the InputElement with id 'txt'
    // Gets all connected devices, returns information about found devices
    chrome.serial.getDevices().then((List<chrome.DeviceInfo> ports) {
      // Loops thru all found devices
      for (var d in ports) {
        // Connects to the $d device, returns informations about the connection
        chrome.serial.connect(d.path).then((chrome.ConnectionInfo conn) {
          // Builds an ArrayBuffer from the value of the input element (:8)
          chrome.ArrayBuffer arrBuffer =new chrome.ArrayBuffer.fromString(input.value);
          // Sends the ArrayBuffer to the device
          chrome.serial.send(conn.connectionId, arrBuffer);
          // Builds and sends an ArrayBuffer with only a zero
          //
          // TODO: find a better solution to tell the Arduino that it's ready to
          // print the message on the display
          chrome.serial.send(conn.connectionId, new chrome.ArrayBuffer.fromBytes([0]));
        });
      }
    });
  });
}
