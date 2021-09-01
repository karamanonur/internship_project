#include "activityapi.h"

activityApi::activityApi()
{
    QEventLoop loop;
    QNetworkAccessManager manager;
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)), &loop, SLOT(quit()));
    QNetworkRequest request( QUrl( QString("https://localhost:5001/Activities")));


    QSslConfiguration conf = request.sslConfiguration();
    conf.setPeerVerifyMode(QSslSocket::VerifyNone);
    request.setSslConfiguration(conf);

    QNetworkReply *reply = manager.get(request);
    loop.exec();

    QString data = (QString)reply->readAll();
    QJsonDocument jsonResponse = QJsonDocument::fromJson(data.toUtf8());

    jsonArr = jsonResponse.array();

    for(int i=0; i<jsonArr.size(); i++)
    {
        jsonObj = jsonArr[i].toObject();
        nameVector.append(jsonObj["name"].toString());
        typeVector.append(jsonObj["type"].toString());
        dateVector.append(jsonObj["date"].toString());
        locationVector.append(jsonObj["location"].toString());
    }

    delete reply;
}

//QVector<QString> activityApi::getName()
//{
//    for(int i=1; i<nameVector.size(); ++i)
//    {
//        qDebug()<<i<<"Event Name: "<<nameVector[i]<<"\n";
//    }
//    return nameVector;

//}


void activityApi::getAll()
{
    QObject* object = getObj3();

    for(int i=0; i<nameVector.size(); i++)
    {
        QMetaObject::invokeMethod(object, "printEvents",
                Q_ARG(QVariant, nameVector[i]),
                Q_ARG(QVariant, typeVector[i]),
                Q_ARG(QVariant, dateVector[i]),
                Q_ARG(QVariant, locationVector[i]));
    }
}

void activityApi::setObj3(QObject *object)
{
    obj3 = object;
}

QObject* activityApi::getObj3(){
    return obj3;
}

int activityApi::getSize(){
    return nameVector.size();
}
