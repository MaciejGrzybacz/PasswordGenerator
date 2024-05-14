#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "generator.h"
#include "clipboardmanager.h"

int main(int argc, char* argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<Generator>("Generator", 1, 0, "Generator");

    qmlRegisterType<ClipboardManager>("ClipboardManager", 1, 0, "ClipboardManager");
    Generator generator;
    ClipboardManager clipboardManager;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("generator", &generator);
    engine.rootContext()->setContextProperty("clipboardManager", &clipboardManager);

    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/passwordgenerator/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
