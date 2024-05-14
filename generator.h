#pragma once

#include <QObject>
#include <QRandomGenerator>
#include <QMetaType>
#include <QString>
#include <QRegularExpression>

class Generator : public QObject {
    Q_OBJECT

public:
    explicit Generator(QObject* parent = nullptr);
    Q_INVOKABLE void setLength(int len);
    Q_INVOKABLE void setLowercases(bool include);
    Q_INVOKABLE void setUppercases(bool include);
    Q_INVOKABLE void setNumbers(bool include);
    Q_INVOKABLE void setSymbols(bool include);
    Q_INVOKABLE void setEasyToRead(bool val);
    Q_INVOKABLE void setEasyToSay(bool val);
    Q_INVOKABLE void setAllChars(bool val);
    Q_INVOKABLE double calculateStrength();
    Q_INVOKABLE QString generatePassword();

private:
    QString generateCharSet();
    int length;
    bool includeLowercases;
    bool includeUppercases;
    bool includeNumbers;
    bool includeSymbols;
    bool easyToRead;
    bool easyToSay;
    bool allChars;
    QRandomGenerator random;
};
