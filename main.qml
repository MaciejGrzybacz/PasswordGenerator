import QtQuick 2.15
import QtQuick.Window 2.2
import QtQuick.Controls 2.15
import Generator 1.0
import ClipboardManager 1.0

Window {
    visible: true
    width: 1920
    height: 1080

    Rectangle {
        id: mainRect
        color: "#E9F6FF" 
        width: parent.width
        height: parent.height

        Button {
            id: copyPasswordButton
            x: 670
            y: mainRect.height - 160 
            width: 320
            height: 80
            text: qsTr("Copy password")
            font.pixelSize: 24
            wheelEnabled: true
            onClicked: {
                if (passwordText.text !== "") {
                    clipboardManager.setText(passwordText.text);
                } else {
                    console.log("No password to copy");
                }
            }
        }

        Rectangle {
            id: passwordDisplayArea
            x: 300
            y: 100
            width: 1100
            height: 150
            radius: 15
            border.color: "lightgray"
            border.width: 1

            ProgressBar {
                id: strength
                x: 0
                y: 130
                width: 1100
                height: 20
                value: generator.calculateStrength()
            }

            Text {
                id: passwordText
                x: 20
                y: 25
                width: 1000
                height: 85
                text: generator.generatePassword()
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 36
            }
        }

        Rectangle {
            id: config
            x: 300
            y: 300
            width: 1100
            height: 400
            radius: 20
            border.color: "lightgray"
            border.width: 1

            Text {
                id: passwordConfigLabel
                x: 50
                y: 25
                width: 1250
                height: 100
                text: qsTr("Customize your password")
                horizontalAlignment: Text.AlignHLeft
                font.pixelSize: 35
            }

            Rectangle {
                id: line
                color: "lightgrey"
                x: 50
                y: 100
                width: 1000
                height: 2
            }

            Rectangle {
                id: bigLengthRect
                x: 50
                y: 140
                width: 800
                height: 150
                color: "#fdffffff"

                Rectangle {
                    id: lengthRect
                    x: 0
                    y: 75
                    width: 70
                    height: 50
                    color: "#fdffffff"
                    radius: 10
                    border.color: "#161616"
                    border.width: 1

                    Text {
                        id: length
                        x: 0
                        y: 10
                        width: 70
                        height: 30
                        text: qsTr("8")
                        font.pixelSize: 24
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Slider {
                    id: lengthSlider
                    x: 210
                    y: 80
                    width: 230
                    height: 50
                    scale: 2.0
                    from: 5 
                    to: 30
                    value: 8
                    property int lastIntValue: 8

                    onValueChanged: {
                        var currentIntValue = Math.round(value);
                        if (currentIntValue !== lastIntValue) {
                            lastIntValue = currentIntValue;
                            length.text = currentIntValue.toFixed(0);
                            generator.setLength(currentIntValue);
                            passwordText.text = generator.generatePassword();
                            strength.value = generator.calculateStrength();
                        }
                    }
                    onActiveFocusChanged: {
                        if (activeFocus) {focus = false;}
                    }
                }


                Text {
                    id: lengthLabel
                    x: 0
                    y: 00
                    width: 200
                    height: 60
                    text: qsTr("Password Length")
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHLeft
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Rectangle {
                id: optionsRect
                x: 650
                y: 130
                width: 400
                height: 240

                RadioButton {
                    id: easyToSayRadio
                    x: 70
                    y: 50
                    scale: 2.5
                    text: qsTr("Easy to say")
                    font.pixelSize: 8
                    onCheckedChanged: {
                        if (checked) {
                            numbersCheck.checked = false;
                            symbolsCheck.checked = false;
                            numbersCheck.enabled = false;
                            symbolsCheck.enabled = false;
                        } else {
                            numbersCheck.enabled = true;
                            symbolsCheck.enabled = true;
                        }
                        generator.setEasyToSay(checked);
                        passwordText.text = generator.generatePassword();
                    }
                    onActiveFocusChanged: {
                        if (activeFocus) {focus = false;}
                    }
                }

                RadioButton {
                    id: easyToReadRadio
                    x: 73
                    y: 110
                    scale: 2.5
                    text: qsTr("Easy to read")
                    font.pixelSize: 8
                    onCheckedChanged: {
                        generator.setEasyToRead(checked);
                        passwordText.text = generator.generatePassword();
                    }
                    onActiveFocusChanged: {
                        if (activeFocus) {focus = false;}
                    }
                }

                RadioButton {
                    id: allCharsRadio
                    x: 75
                    y: 170
                    scale: 2.5
                    text: qsTr("All characters")
                    font.pixelSize: 8
                    onCheckedChanged: {
                        generator.setAllChars(checked);
                        passwordText.text = generator.generatePassword();
                    }
                    onActiveFocusChanged: {
                        if (activeFocus) {focus = false;}
                    }
                }

                CheckBox {
                    id: lowercaseCheck
                    x: 300
                    y: 20
                    scale: 2.5
                    font.pixelSize: 8
                    text: qsTr("Lowercase")
                    checked: true
                    onCheckedChanged: {
                        generator.setLowercases(checked);
                        strength.value = generator.calculateStrength();
                        passwordText.text = generator.generatePassword();
                    }
                    onActiveFocusChanged: {
                        if (activeFocus) {focus = false;}
                    }
                }

                CheckBox {
                    id: uppercaseCheck
                    x: 300
                    y: 80
                    scale: 2.5
                    font.pixelSize: 8
                    text: qsTr("Uppercase")
                    onCheckedChanged: {
                        generator.setUppercases(checked);
                        strength.value = generator.calculateStrength();
                        passwordText.text = generator.generatePassword();
                    }
                    onActiveFocusChanged: {
                        if (activeFocus) {focus = false;}
                    }
                }

                CheckBox {
                    id: numbersCheck
                    x: 296
                    y: 140
                    scale: 2.5
                    font.pixelSize: 8
                    text: qsTr("Numbers")
                    enabled: !easyToSayRadio.checked 
                    onCheckedChanged: {
                        generator.setNumbers(checked);
                        strength.value = generator.calculateStrength();
                        passwordText.text = generator.generatePassword();
                    }
                    onActiveFocusChanged: {
                        if (activeFocus) {focus = false;}
                    }
                }

                CheckBox {
                    id: symbolsCheck
                    x: 295
                    y: 200
                    scale: 2.5
                    font.pixelSize: 8
                    text: qsTr("Symbols")
                    enabled: !easyToSayRadio.checked 
                    onCheckedChanged: {
                        generator.setSymbols(checked);
                        strength.value = generator.calculateStrength();
                        passwordText.text = generator.generatePassword();
                    }
                    onActiveFocusChanged: {
                        if (activeFocus) {focus = false;}
                    }
                }
            }
        }
    }
    Generator {
        id: generator 
    }

    ClipboardManager {
        id: clipboardManager
    }
}
