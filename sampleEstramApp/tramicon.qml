import QtQuick 2.0
import QtLocation 5.12

MapQuickItem {
    id:tramicon
    anchorPoint.x:tramicon.width/2
    anchorPoint.y:tramicon.height/2
    sourceItem:Image{
        id:tram
        source:"qrc:/img/tram.png"
        sourceSize.width: 25
        sourceSize.height: 25
    }
}
