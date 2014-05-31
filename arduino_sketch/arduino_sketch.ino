// Includes LiquidCrystal library to control an LCD screen
#include <LiquidCrystal.h>

// Incoming byte
int inByte;
// String buffer
String buffer;
// LCD setup
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup() {
    // Initializes `buffer' to ""
    buffer = "";
    // Sets the baud rate for serial data transmission
    Serial.begin(9600);
    // Initializes the interface to the LCD screen
    lcd.begin(16, 2);
}

void loop() {
    // Serial.available gets the number of bytes available for reading
    if (Serial.available() > 0) {
        // Sets read byte to `inByte'
        inByte = Serial.read();
        // When inByte == 0, buffer is printed to lcd
        if (inByte == 0) {
            // Clears the lcd screen
            lcd.clear();
            // Prints the buffer
            lcd.print(buffer);
            // If buffer is longer than 16 chars it is printed on 2 rows
            if (buffer.length() > 16) {
                // Moves the cursor to column 0, row 1
                lcd.setCursor(0, 1);
                // Prints a substring of buffer starting from position 16
                lcd.print(buffer.substring(16));
            }
            // Buffer reset
            buffer = "";
        } else {
            // Converts byte to char and adds it to buffer
            buffer += (char) inByte; 
        }
        // ???
    }
    /// Profit
}
