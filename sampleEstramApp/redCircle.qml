import QtQuick 2.0
import QtLocation 5.12

MapQuickItem {
    id:greencircle
    anchorPoint.x:greencircle.width/2
    anchorPoint.y:greencircle.height/2
    sourceItem:Image{
        id:greencircleimage
        source:"qrc:/img/redCircle.png"
        sourceSize.width: 50
        sourceSize.height: 50
    }
}
