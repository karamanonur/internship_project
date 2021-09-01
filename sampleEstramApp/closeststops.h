#ifndef CLOSESTSTOPS_H
#define CLOSESTSTOPS_H

#include <QGuiApplication>
#include <QObject>
#include <QQmlComponent>
#include <QQmlApplicationEngine>
#include <QString>
#include <QMetaObject>
#include "tramStops.h"

class closestStops:public QObject{
    Q_OBJECT
    QObject* obj2;
public:
    Q_INVOKABLE void smallestDistance();
    void setObj2(QObject* object);
    QObject* getObj2();
};

#endif // CLOSESTSTOPS_H
