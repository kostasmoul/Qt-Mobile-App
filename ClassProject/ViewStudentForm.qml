import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2

Rectangle {

    property string theName
    property string theImage
    property string theObs
    property double theMo

    width:400
    height:600

    ToolBar
    {
        id:viewToolBar


        style: ToolBarStyle {
            padding {
                left: 8
                right: 8
                top: 3
                bottom: 3
            }
            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: 40
                border.color: "#58C9B9"
                gradient: Gradient {
                    GradientStop { position: 0 ; color: "#58C9B9" }
                    GradientStop { position: 1 ; color: "#9DC8C8" }
                }
            }
        }//end of style




        Label{
            text:theName

            anchors.centerIn: parent
            color:"#1f4e5f"
            font.family: "comic sans ms"
            font.bold: true
            font.wordSpacing: 1
            font.pixelSize: 16

        }
        ToolButton{
            anchors.left:parent.left
            id:returnIcon
            width:25
            height:25
            anchors.verticalCenter: parent.verticalCenter
            Image{
                source: "images/Reply Arrow-30.png"
                anchors.fill: parent
                anchors.margins:2
            }
            onClicked:
            {
                stack.pop();
            }
        }
    }//end of toolbar

    Rectangle{
        id:imageBooth

        width:parent.width/3
        height:parent.height/6
        anchors.top:viewToolBar.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: "black"
        border.width:2
        radius:5

        Image{
            id:imageOfStudent
            anchors.fill:parent
            fillMode: Image.PreserveAspectFit
            anchors.margins: 2
            source:theImage


        }

    }

    Label{
        id:obsTitle
        anchors.top:imageBooth.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 40
        font.family: "comic sans ms"
        font.bold:true
        color:"black"
        font.pixelSize: 16
        text:"Observations"
    }

    Rectangle{
        id:observationsRec
        width:parent.width-10
        height:parent.height/6
        anchors.top:obsTitle.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: "black"
        border.width:2
        radius:5
        Label{
            id:obs
            anchors.fill:parent
            anchors.margins: 3
            text:theObs
            font.family: "comic sans ms"
            color:"black"
            font.pixelSize: 14


        }

    }

    Label{
        id:mesos
        anchors.top:observationsRec.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 25
        text:"Μέσος Όρος: "+Number(theMo).toPrecision(2);
        font.family: "comic sans ms"
        color:"black"
        font.bold:true
        font.pixelSize: 24
    }







}
