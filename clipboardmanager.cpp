#include "clipboardmanager.h"

ClipboardManager::ClipboardManager(QObject* parent)
    : QObject(parent) {
    clipboard = QGuiApplication::clipboard();
}

void ClipboardManager::setText(const QString& text) {
    clipboard->setText(text, QClipboard::Clipboard);
}

QString ClipboardManager::getText() {
    return clipboard->text(QClipboard::Clipboard);
}
