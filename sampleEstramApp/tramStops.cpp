#include "tramStops.h"

getTramStops::getTramStops(QObject *_parent){
    QEventLoop loop;
    QNetworkAccessManager manager;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &loop, SLOT(quit()));
    QNetworkRequest request( QUrl( QString("https://overpass-api.de/api/interpreter?data=%2F*%0AThis%20has%20been%20generated%20by%20the%20overpass-turbo%20wizard.%0AThe%20original%20search%20was%3A%0A“railway%3Dtram_stop%20in%20Eskişehir”%0A*%2F%0A%5Bout%3Ajson%5D%5Btimeout%3A25%5D%3B%0A%2F%2F%20fetch%20area%20“Eskişehir”%20to%20search%20in%0Aarea%283600223421%29->.searchArea%3B%0A%2F%2F%20gather%20results%0A%28%0A%20%20%2F%2F%20query%20part%20for%3A%20“railway%3Dtram_stop”%0A%20%20node%5B\"railway\"%3D\"tram_stop\"%5D%28area.searchArea%29%3B%0A%20%20way%5B\"railway\"%3D\"tram_stop\"%5D%28area.searchArea%29%3B%0A%20%20relation%5B\"railway\"%3D\"tram_stop\"%5D%28area.searchArea%29%3B%0A%29%3B%0A%2F%2F%20print%20results%0Aout%20body%3B%0A>%3B%0Aout%20skel%20qt%3B")));
    QNetworkReply *reply = manager.get(request);
    loop.exec();

    QString data = (QString)reply->readAll();
    QJsonDocument jsonResponse = QJsonDocument::fromJson(data.toUtf8());

    jsonObj = jsonResponse.object();
    jsonArr = jsonObj["elements"].toArray();
    delete reply;
}

//double getTramStops::getLat(){
//    double* lat = new double[jsonArr.size()];
//    lat[0]=jsonArr[0].toObject()["lat"].toDouble();
//    return *lat;
//}

//double getTramStops::getLon(){
//    double* lon = new double[jsonArr.size()];
//    lon[0]=jsonArr[0].toObject()["lon"].toDouble();
//    return *lon;
//}

//void getTramStops::addTram(){
//    QQmlEngine eng;
//    QQmlComponent comp(&eng, "qrc:/main.qml");
//    QObject *obj = comp.create();
//    double* lat = new double [jsonArr.size()];
//    double* lon = new double [jsonArr.size()];
//    for(int i=0; i<jsonArr.size(); i++){
//        lat[i]=jsonArr[i].toObject()["lat"].toDouble();
//        lon[i]=jsonArr[i].toObject()["lon"].toDouble();
//        QMetaObject::invokeMethod(obj, "addTramIcon", Q_ARG(QVariant, lat[i]),Q_ARG(QVariant, lon[i]));
//    }
//}

void getTramStops::stopsIteration(QObject* object){
    for(int i=0; i<jsonArr.size(); i++){
        QMetaObject::invokeMethod(object, "addTramIcon",
                Q_ARG(QVariant, jsonArr[i].toObject()["lat"].toDouble()),
                Q_ARG(QVariant, jsonArr[i].toObject()["lon"].toDouble()));
        QMetaObject::invokeMethod(object, "addStopNameAndCoord",
                Q_ARG(QVariant, jsonArr[i].toObject()["tags"].toObject()["name"].toString()),
                Q_ARG(QVariant, jsonArr[i].toObject()["lat"].toDouble()),
                Q_ARG(QVariant, jsonArr[i].toObject()["lon"].toDouble()));
    }
}


