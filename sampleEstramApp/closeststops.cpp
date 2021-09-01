#include "closeststops.h"

void closestStops::smallestDistance(){
    QObject* object = getObj2();
    getTramStops stopCoords;
    double nonAcceptableDistance = 50;
    QVariant distance;
    double dist;
    double finalDistance = 100;
    double lat, lon;
    QString stopName;
    QString finalStopName;
    double finalLat;
    double finalLon;
    for(int i=0; i<stopCoords.jsonArr.size(); i++){
        lat =  stopCoords.jsonArr[i].toObject()["lat"].toDouble();
        lon = stopCoords.jsonArr[i].toObject()["lon"].toDouble();
        stopName = stopCoords.jsonArr[i].toObject()["tags"].toObject()["name"].toString();
        QMetaObject::invokeMethod(object, "closestStoptoCurLoc",
                                  Q_RETURN_ARG(QVariant, distance),
                                  Q_ARG(QVariant, lat),
                                  Q_ARG(QVariant, lon));
        dist = distance.toDouble();
        if(dist<finalDistance){
            finalDistance = dist;
            finalLat = lat;
            finalLon = lon;
            finalStopName = stopName;
        }
    }
    if(finalDistance<nonAcceptableDistance){
        QMetaObject::invokeMethod(object, "addRedCircle",
                                  Q_ARG(QVariant, finalLat),
                                  Q_ARG(QVariant, finalLon));

        QMetaObject::invokeMethod(object, "printClosestStop",
                                  Q_ARG(QVariant, finalStopName),
                                  Q_ARG(QVariant, finalDistance));
    }else
        QMetaObject::invokeMethod(object, "gpsProblem");
}

void closestStops::setObj2(QObject *object)
{
    obj2 = object;
}

QObject* closestStops::getObj2(){
    return obj2;
}
