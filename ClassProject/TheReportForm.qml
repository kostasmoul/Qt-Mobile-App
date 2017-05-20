import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2

Rectangle {
    width:400
    height:600


    ToolBar
    {
        id:reportToolBar


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
            text:"Αναλυτικές Βαθμολογήσεις"

            anchors.centerIn: parent
            color:"#1f4e5f"
            font.family: "comic sans ms"
            font.bold: true
            font.wordSpacing: 1
            font.pixelSize: 14

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

    ListView{
        id:reportListView
        width:parent.width
        height:parent.height
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.top:reportToolBar.bottom
        anchors.bottom: parent.bottom
        spacing:5
        model:m.subjectModel
        delegate:Rectangle{
            id:rec
            width:parent.width
            height:120
            border.width:2
            border.color:"black"
            radius:5
            Label{
                id:name
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top:rec.top
                anchors.topMargin: 5
                text:studentOfSubject
                font.pixelSize: 15
                font.bold: true
                font.family: "comic sans ms"
                font.wordSpacing: 1
            }


            Label{
                id:classLabel
                anchors.top:name.bottom
                anchors.left: rec.left
                anchors.leftMargin: 10
                text:"Μάθημα:"
                font.pixelSize: 15
                font.bold: true
                font.italic: true
                font.family: "comic sans ms"
                font.wordSpacing: 1
            }
            Label{

                id:classLabelResult
                anchors.top:name.bottom
                anchors.left:classLabel.right
                anchors.leftMargin: 4
                font.pixelSize: 15
                font.bold: true
                font.italic: true
                font.family: "comic sans ms"
                font.wordSpacing: 1
                text:subName
                color:"red"
            }
            Label{

                id:test1Label
                anchors.top:classLabel.bottom
                anchors.left:rec.left
                anchors.leftMargin: 10
                font.pixelSize: 15
                font.family: "comic sans ms"
                font.wordSpacing: 1
                text:"Test 1:"
                font.bold: true
                font.italic: true
            }
            Label{

                id:test1Result
                anchors.top:classLabelResult.bottom
                anchors.left:test1Label.right
                anchors.leftMargin:5
                font.pixelSize: 15
                font.bold: true
                font.italic: true
                font.family: "comic sans ms"
                font.wordSpacing: 1
                color:"red"
                text:t1


            }
            Label{

                id:test2Label
                anchors.top:test1Label.bottom
                anchors.left:rec.left
                anchors.leftMargin: 10
                font.pixelSize: 15
                font.family: "comic sans ms"
                font.wordSpacing: 1
                text:"Test 2:"
                font.bold: true
                font.italic: true
            }
            Label{

                id:test2Result
                anchors.top:test1Result.bottom
                anchors.left: test2Label.right
                anchors.leftMargin: 5
                font.pixelSize: 15
                font.bold: true
                font.italic: true
                font.family: "comic sans ms"
                font.wordSpacing: 1
                color:"red"
                text:t2
            }
            Label{

                id:test3Label
                anchors.top:test2Label.bottom
                anchors.left:rec.left
                anchors.leftMargin:10
                font.pixelSize: 15
                font.family: "comic sans ms"
                font.wordSpacing: 1
                text:"Test 3:"
                font.bold: true
                font.italic: true
            }
            Label{

                id:test3Result
                anchors.top:test2Result.bottom
                anchors.left:test3Label.right
                anchors.leftMargin: 5
                font.pixelSize: 15
                font.bold: true
                font.italic: true
                font.family: "comic sans ms"
                font.wordSpacing: 1
                color:"red"
                text:t3
            }
            MouseArea{
                id:deleteButton
                width:16
                height:16
                anchors.right:parent.right
                anchors.top:parent.top
                anchors.rightMargin: 5
                anchors.topMargin: 5

            Image{


                anchors.fill:parent
                source:"images/delicon.png"


            }
            onClicked: {

               reportListView.currentIndex=index
                m.deleteSubject(reportListView.currentIndex); //διαγράφει το αντικείμενο Subject ,που είχαμε δημιουργήσει ,από το SubjectModel (συγκεκριμένα το διαγράφει από τη λίστα myData τoυ SubjectModel)

            }

            }

        }
    }





}
