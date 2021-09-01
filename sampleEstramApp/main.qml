import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtLocation 5.12
import QtPositioning 5.12

ApplicationWindow {
    id:appWin
    width: 1200
    height: 700
    visible: true
    title: qsTr("Sample Estram Application")

    property double bluePinLat
    property double bluePinLon
    property var redCircleItem

    Plugin {
        id:mapPlugin
        name:"osm"
        PluginParameter{name:"osm.mapping.providersrepository.disabled";value:true}
    }

    Map {
        id: map
        copyrightsVisible: false
        width: parent.width/1.2
        anchors{
            right:parent.right
            top: parent.top
            bottom: parent.bottom
        }
        plugin: mapPlugin
        center: QtPositioning.coordinate(39.771101, 30.524903)
        zoomLevel: 13

        Behavior on center {
            CoordinateAnimation {
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }

        PositionSource {
            id: currentlocation
            updateInterval: 1000
            active: false
        }

        MapPolyline {
            id: polyLine
            line.width: 0
            line.color: "transparent"
            smooth: true
            path:[greenPinMark.coordinate, redPinMark.coordinate]
        }

        MapQuickItem {
            id: currentlocationdot
            sourceItem: Image {
                id: currentlocationImage
                source: "qrc:/img/youAreHere.png"
                sourceSize.width: 50
                sourceSize.height: 50
            }
            coordinate: currentlocation.position.coordinate
            anchorPoint.x: currentlocationImage.width/2
            anchorPoint.y: currentlocationImage.height/2
        }
        MapQuickItem {
            id: bluePinMark
            visible: true
            sourceItem: Image {
                id: bluePinImage
                source: "qrc:/img/bluePin.png"
                sourceSize.width: 25
                sourceSize.height: 35
            }
            coordinate{
                latitude: bluePinLat
                longitude: bluePinLon
            }
            anchorPoint.x: bluePinImage.width/2.1
            anchorPoint.y: bluePinImage.height
        }
        MapQuickItem {
            id: redPinMark
            visible: false
            sourceItem: Image {
                id: redPinImage
                source: "qrc:/img/redPin.png"
                sourceSize.width: 30
                sourceSize.height: 30
            }
            coordinate: map.center
            anchorPoint.x: redPinImage.width/2
            anchorPoint.y: redPinImage.height/1.2
        }
        MapQuickItem {
            id: greenPinMark
            visible: false
            sourceItem: Image {
                id: greenPinImage
                source: "qrc:/img/greenPin.png"
                sourceSize.width: 25
                sourceSize.height: 25
            }
            coordinate: map.center
            anchorPoint.x: greenPinImage.width/2
            anchorPoint.y: greenPinImage.height
        }

        Rectangle {
            id: textRectangle
            color: "transparent"
            anchors.fill: parent
            Text {
                id: rectText
                anchors {
                    top: parent.top
                    topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }
                text: ""
                color: "black"
                font.pixelSize: 25
            }
        }
        Rectangle {
            id: closestStopRect
            color: "lightgray"
            height:30
            anchors {
                right: parent.right
                left: parent.left
                bottom: parent.bottom
            }
            Text {
                id: closestStopText
                anchors.left: parent.left
                anchors.leftMargin: 10
                text: ""
                color: "red"
                font.pixelSize: 15
            }
        }

        MouseArea {
            id: startingPointMouseArea
            anchors.fill: parent
            enabled: false
            onDoubleClicked: {
                greenPinMark.coordinate = map.toCoordinate((Qt.point(mouse.x, mouse.y)))
            }
        }
        MouseArea {
            id: destinationMouseArea
            anchors.fill: parent
            enabled: false
            onDoubleClicked: {
                redPinMark.coordinate = map.toCoordinate(Qt.point(mouse.x, mouse.y))
            }
        }

    }

    Button {
        id: startbutton
        height: 50
        width: parent.width - map.width
        anchors {
            top: parent.top
            left: parent.left
        }
        Rectangle {
            anchors.fill: parent
            color: "blue"
            opacity: 0.5
            border.color: "black"
            border.width: 1
        }
        font.family: "Arial" ; font.pixelSize: 15
        text: "<b>Starting Point</b>"

        onClicked: {
            polyLine.visible = false
            greenPinMark.visible = true
            redPinMark.visible = true
            startingPointMouseArea.enabled = (startingPointMouseArea.enabled == true) ? false : true
            destinationMouseArea.enabled = false
            startbutton.text = (startbutton.text == "<b>Starting Point</b>") ? "<b>Confirm</b>" : "<b>Starting Point</b>"
            if(startbutton.text=="<b>Confirm</b>") destinationbutton.enabled = false
            else destinationbutton.enabled = true
            if(startbutton.text=="<b>Confirm</b>") getDistanceButton.enabled = false
            else getDistanceButton.enabled = true
            if(getDistanceButton.text=="<b>Clear Distance</b>") getDistanceButton.text = "<b>Get Distance</b>"
        }

    }
    Button {
        id: destinationbutton
        height: 50
        width: parent.width - map.width
        anchors{
            top: startbutton.bottom
            left: parent.left
        }
        Rectangle{
            anchors.fill: parent
            color: "blue"
            opacity: 0.5
            border.color: "black"
            border.width: 1
        }
        font.family: "Arial" ; font.pixelSize: 15
        text: "<b>Destination</b>"
        onClicked: {
            polyLine.visible = false
            redPinMark.visible = true
            greenPinMark.visible = true
            destinationMouseArea.enabled = (destinationMouseArea.enabled == true) ? false : true
            startingPointMouseArea.enabled = false
            destinationbutton.text = (destinationbutton.text == "<b>Destination</b>") ? "<b>Confirm</b>" : "<b>Destination</b>"
            if(destinationbutton.text=="<b>Confirm</b>") startbutton.enabled = false
            else startbutton.enabled = true
            if(destinationbutton.text=="<b>Confirm</b>") getDistanceButton.enabled = false
            else getDistanceButton.enabled = true
            if(getDistanceButton.text=="<b>Clear Distance</b>") getDistanceButton.text = "<b>Get Distance</b>"
        }
    }
    Button {
        id: getDistanceButton
        height: 50
        width: parent.width - map.width
        anchors{
            top: destinationbutton.bottom
            left: parent.left
        }
        Rectangle{
            anchors.fill: parent
            color: "blue"
            opacity: 0.5
            border.color: "black"
            border.width: 1
        }
        font.family: "Arial" ; font.pixelSize: 15
        text: "<b>Get Distance</b>"
        onClicked: {
            if(getDistanceButton.text == "<b>Get Distance</b>"){
                var distance = getDistance(greenPinMark.coordinate.latitude, greenPinMark.coordinate.longitude,
                            redPinMark.coordinate.latitude, redPinMark.coordinate.longitude)
                rectText.text = distance + " km"
                polyLine.visible = true
                greenPinMark.visible = true
                redPinMark.visible = true
                getDistanceButton.text = "<b>Clear Distance</b>"
            }else{
                getDistanceButton.text = "<b>Get Distance</b>"
                rectText.text = ""
                polyLine.visible = false
                greenPinMark.visible = false
                redPinMark.visible = false
            }
        }
    }

    Button {
        id: eventButton
        height: 50
        width: parent.width - map.width
        anchors{
            top: getDistanceButton.bottom
            left: parent.left
        }
        Rectangle{
            anchors.fill: parent
            color: "orange"
            opacity: 1
            border.color: "black"
            border.width: 1
        }
        font.family: "Arial" ; font.pixelSize: 15
        text: "<b>Click to see events</b>"
        onClicked: {
            if(nameList.visible == true)
            {
                nameList.visible = false;
                eventList.visible = true;
            }
            else
            {
                eventList.visible = false;
                nameList.visible = true;
            }
        }
    }

    Button {
        id: locButton
        text: "<b>Location</b>"
        width:100 ; height:50
        anchors.right:parent.right
        anchors.top: parent.top
        Rectangle{
            id: locButtonRect
            anchors.fill: parent
            color: "red"
            opacity: 0.5
        }

        onClicked: {
            delete currentlocation.position.coordinate
            if(currentlocation.active == false){
                locButtonRect.color= "green"
                currentlocation.active = true
                currentlocationImage.visible = true
                __closestSt.smallestDistance();
            }
            else {
                currentlocation.active = false
                currentlocationImage.visible = false
                map.removeMapItem(redCircleItem)
                closestStopText.text = ""
                locButtonRect.color = "red"
            }
        }
    }

    Component.onCompleted: {
        currentlocationImage.visible = false
    }

    ListModel {
        id: stopNames
    }
    Component {
        id: nameDelegate
        Text {
            readonly property ListView __lvName: ListView.view
            text: model.name;
            font.pixelSize: 17
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    __lvName.currentIndex = model.index
                    bluePinLat = stopNames.get(__lvName.currentIndex).lat
                    bluePinLon = stopNames.get(__lvName.currentIndex).lon
                    map.center = bluePinMark.coordinate
                }
            }
        }
    }
    ListView {
        id: nameList
        anchors {
            left: parent.left
            top: eventButton.bottom
            topMargin:10
            bottom: parent.bottom
            right: map.left
        }
        width: parent.width - map.width
        model: stopNames
        delegate: nameDelegate
        focus: true
        visible: true

        highlight: Rectangle {
            anchors {
                left: parent.left
                right: parent.right
            }
            color: "lightgreen"
        }
        preferredHighlightBegin:30
        preferredHighlightEnd: 50
        highlightRangeMode: ListView.StrictlyEnforceRange
    }

    ListModel {
        id: eventNames
    }
    Component {
        id: eventDelegate
        Text {
            readonly property ListView __lvName: ListView.view
            text: model.event;
            font.pixelSize: 10
        }
    }
    ListView {
        id: eventList
        anchors {
            left: parent.left
            top: eventButton.bottom
            topMargin:10
            bottom: parent.bottom
            right: map.left
        }
        width: parent.width - map.width
        model: eventNames
        delegate: eventDelegate
        focus: true
        visible: false
        clip: true
    }

    function addTramIcon(latitude, longitude)
    {
        var Component = Qt.createComponent("qrc:/tramicon.qml")
        var item = Component.createObject(appWin,{coordinate: QtPositioning.coordinate(latitude,longitude)})
        map.addMapItem(item)
    }

    function getDistance(lat1, lon1, lat2, lon2)
    {
      var earthRadius = 6371;
      var radLatitude = toRad(lat2-lat1);
      var radLongitude = toRad(lon2-lon1);
      var a = Math.sin(radLatitude/2) * Math.sin(radLatitude/2) +
        Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) *
        Math.sin(radLongitude/2) * Math.sin(radLongitude/2)
      var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
      var distance = earthRadius * c; // Distance in km
      return distance.toFixed(2);
    }

    function toRad(deg) {
      return deg * (Math.PI/180)
    }

    function addStopNameAndCoord(name, lat, lon) {
        stopNames.append({"name": name, "lat":lat, "lon": lon})
    }

    function closestStoptoCurLoc(latitude, longitude)
    {
        var coord = currentlocation.position.coordinate
        var closest = getDistance(coord.latitude, coord.longitude, latitude, longitude)
        var floatClosest = parseFloat(closest)
        return floatClosest
    }

    function addRedCircle(latitude, longitude)
    {
        var Component = Qt.createComponent("qrc:/redCircle.qml")
        redCircleItem = Component.createObject(appWin,{coordinate: QtPositioning.coordinate(latitude,longitude)})
        map.addMapItem(redCircleItem)

    }

    function printClosestStop(name, dist)
    {
        closestStopText.text = "Closest tram stop to your current location: "+ name+"("+dist+" km)"
    }

    function gpsProblem()
    {
        closestStopText.text = "Turn on GPS"
    }

    function printEvents(name, type, date, location)
    {
        eventNames.append({"event":"Name: "+name+"\n"+"Type: "+type+"\n"+
                                   "Date: "+date+ "\n"+"Location: "+location+
                                   "\n"+"------------------"})
    }
}
