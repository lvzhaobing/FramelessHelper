#include <QtGui>
#include <QtWidgets>
#include <QtQml>

#include "MainWindow.h"
#include "WindowFramelessHelper.h"
#include "FramelessWindow.h"

int main(int argc, char *argv[])
{
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication::setAttribute(Qt::AA_UseOpenGLES);
    QApplication a(argc, argv);

    qmlRegisterType<FramelessWindow>("Frameless.Window", 1, 0, "FramelessWindow");
    qmlRegisterType<WindowFramelessHelper>("Frameless.Window", 1, 0, "FramelessHelper");

    QQmlApplicationEngine engine;
#ifdef  Q_OS_WIN
    QUrl url = QUrl(QStringLiteral("qrc:/qml/main.qml"));
#else
    QUrl url = QUrl(QStringLiteral("qrc:/qml/unix_main.qml"));
#endif
    engine.load(url);
    if (engine.rootObjects().isEmpty())
        return -1;

    MainWindow w;
    w.show();

    return a.exec();
}
