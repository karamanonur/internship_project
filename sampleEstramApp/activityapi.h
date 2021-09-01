#ifndef ACTIVITYAPI_H
#define ACTIVITYAPI_H

#include <QObject>

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QUrlQuery>
#include <QJsonObject>
#include <QJsonDocument>
#include <QByteArray>
#include <QJsonArray>
#include <QFile>
#include <QQmlComponent>

class activityApi
{
    QObject* obj3;
public:
    activityApi();
    QJsonArray jsonArr;
    QJsonObject jsonObj;
    QVector<QString> nameVector;
    QVector<QString> typeVector;
    QVector<QString> dateVector;
    QVector<QString> locationVector;
    void setObj3(QObject* object);
    QObject* getObj3();


//    QVector<QString> getName();
//    QVector<QString> getType();
//    QVector<QString> getDate();
//    QVector<QString> getLocation();

signals:

public slots:
    void getAll();
    int getSize();
};

#endif // ACTIVITYAPI_H
