#ifndef CLIPBOARDMANAGER_H
#define CLIPBOARDMANAGER_H

#include <QObject>
#include <QClipboard>
#include <QGuiApplication>

class ClipboardManager : public QObject {
    Q_OBJECT

public:
    explicit ClipboardManager(QObject* parent = nullptr);

    Q_INVOKABLE void setText(const QString& text);
    Q_INVOKABLE QString getText();

private:
    QClipboard* clipboard;
};

#endif // CLIPBOARDMANAGER_H
