#include "Generator.h"

Generator::Generator(QObject* parent)
    : QObject(parent), length(8), includeLowercases(true), includeUppercases(false), includeNumbers(false), includeSymbols(false), easyToRead(false), easyToSay(false), allChars(true){}

void Generator::setLength(int len) {
    length = len;
}

void Generator::setLowercases(bool include) {
    includeLowercases = include;
}

void Generator::setUppercases(bool include) {
    includeUppercases = include;
}

void Generator::setNumbers(bool include) {
    includeNumbers = include;
}

void Generator::setSymbols(bool include) {
    includeSymbols = include;
}

Q_INVOKABLE void Generator::setEasyToRead(bool val)
{
    easyToRead = val;
}

Q_INVOKABLE void Generator::setEasyToSay(bool val)
{
    easyToSay = val;
}

Q_INVOKABLE void Generator::setAllChars(bool val)
{
    allChars = val;
}

Q_INVOKABLE double Generator::calculateStrength()
{
    double strength = 0.0;

    if (length < 8) {
        strength = 0.15; 
    }
    else {
        strength = 0.15 + 0.08 * (length - 8);
    }

    if (includeLowercases) {
        strength *= 1.5;
    }
    if (includeUppercases) {
        strength *= 1.5;
    }
    if (includeNumbers) {
        strength *= 1.25;
    }
    if (includeSymbols) {
        strength *= 1.5;
    }

    strength = qBound(0.0, strength, 1.0);

    return strength;
}


QString Generator::generatePassword() {
    QString charSet = generateCharSet();
    if (charSet.length() == 0) {
        return "Please check at least one option!";
    }
    QString password;
    if (easyToRead) {
        QRegularExpression regex("[l1O0]");
        charSet.remove(regex);
    }
    for (int i = 0; i < length; i++) {
        int index = random.bounded(charSet.length());
        password.append(charSet.at(index));
    }
    return password;
}

QString Generator::generateCharSet() {
    QString charSet;
    if (includeLowercases) charSet.append("abcdefghijklmnopqrstuvwxyz");
    if (includeUppercases) charSet.append("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
    if (includeNumbers) charSet.append("0123456789");
    if (includeSymbols) charSet.append("!@#$%^&*()_-+=[]{}|;:,.<>/?");

    return charSet;
}
