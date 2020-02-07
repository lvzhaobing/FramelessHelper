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
    QUrl url = QUrl(QStringLiteral("qrc:/qml/main.qml"));
    engine.load(url);
    if (engine.rootObjects().isEmpty())
        return -1;
#if defined (Q_OS_WIN) || defined (Q_OS_MAC)
    //QWidget FramelessWindow on Linux platform is not supported temporarily
    MainWindow w;
    w.show();
#endif
    return a.exec();
}
