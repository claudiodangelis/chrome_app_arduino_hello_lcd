
chrome.app.runtime.onLaunched.addListener(function(launchData) {
  chrome.app.window.create('chrome_app_arduino_hello_lcd.html', {
    'id': '_mainWindow', 'bounds': {'width': 800, 'height': 600 }
  });
});
