#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QGeoPath>
#include <QQmlContext>
#include <QQuickItem>
#include "tramStops.h"
#include "closeststops.h"
#include "activityapi.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    getTramStops tramStop;
    closestStops closestStop;
    activityApi activity;
    engine.rootContext()->setContextProperty("__closestSt",&closestStop);
    QQmlComponent component(&engine, "qrc:/main.qml");
    QObject *obj = component.create();
    tramStop.stopsIteration(obj);
    closestStop.setObj2(obj);
    activity.setObj3(obj);
    activity.getAll();

    /*engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);*/
    //delete obj;
    return app.exec();
    delete obj;
}
