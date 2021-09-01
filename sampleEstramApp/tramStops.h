#ifndef TRAMSTOPS_H
#define TRAMSTOPS_H

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
#include <QObject>
#include <QQmlComponent>

class getTramStops:public QObject{
    Q_OBJECT
public:
    Q_INVOKABLE getTramStops(QObject* parent = 0);
    Q_INVOKABLE void stopsIteration(QObject* object);
    QJsonArray jsonArr;
    QJsonObject jsonObj;
};

#endif // TRAMSTOPS_H
