import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2

Rectangle {
    width:400
    height:600
    Component
    {
        id:isf
        InsertStudentForm{id:form;}
    }

    Component{
        id:reportForm
        TheReportForm{}
    }

    Component{

        id:vsf
        ViewStudentForm{}
    }

    ToolBar
    {
        id:myToolBar

        style: ToolBarStyle {
            padding {
                left: 8
                right: 8
                top: 3
                bottom: 3
            }
            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: 40 //
                border.color: "#58C9B9"
                gradient: Gradient {
                    GradientStop { position: 0 ; color: "#58C9B9" }
                    GradientStop { position: 1 ; color: "#9DC8C8" }
                }
            }
        }//end of style

        Label{
            text:"ΟΙ ΜΑΘΗΤΕΣ ΜΟΥ"
            font.family: "comic sans ms"
            anchors.centerIn: parent
            color:"#1f4e5f"
            font.bold: true
            font.wordSpacing: 1
            font.pixelSize: 18
        }
        ToolButton{
            anchors.right:parent.right
            id:addIcon
            width:32
            height:32
            anchors.verticalCenter: parent.verticalCenter
            Image{
               source:"images/sign-add-icon.png"
               anchors.fill:parent
               anchors.margins:2

            }
            onClicked: {
                stack.push(isf);
            }
        }
        ToolButton{
            anchors.left:parent.left
            id:reportIcon
            width:32
            height:32
            anchors.verticalCenter: parent.verticalCenter
            Image{
                source:"images/report3.png"
                anchors.fill:parent
                anchors.margins: 2
            }
            onClicked: {
                stack.push(reportForm);
            }
        }
    }//end of toolbar

    ListView{
        id:myListView
        width:parent.width
        height:parent.height
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: myToolBar.bottom
        anchors.bottom: parent.bottom
        spacing:10
        model:m.studentModel
        delegate: Rectangle{
            id:rect
            width:parent.width
            height:96
            MouseArea{
                anchors.fill: rect
                onClicked:
                {
                    stack.push({item:vsf, properties:{theName: studentName,theImage:image, theObs: observations, theMo:moStudent}});


                }
            }
            border.width:2
            radius:5

            Image{
                height:rect.height
                width:100
                id:img
                source:image //έτσι έχουμε ονομάσει το property του ImgPathRole στο StudentModel
                anchors.left: parent.left
                anchors.leftMargin: 2
                anchors.top:parent.top
                anchors.topMargin: 2
                anchors.bottom:parent.bottom
                anchors.bottomMargin: 2


            }
            Label{
                id:aLabel
                anchors.left:img.right
                anchors.verticalCenter: rect.verticalCenter
                font.pixelSize: 14
                text:studentName//έτσι έχουμε ονομάσει το property του NameRole στο StudentModel
                color:"black"
                anchors.leftMargin: 10
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

                myListView.currentIndex=index
                m.deleteStudent(myListView.currentIndex); //διαγράφει το αντικείμενο Student που είχαμε δημιουργήσει από το StudentModel (συγκεκριμένα το διαγράφει από τη λίστα myData τoυ StudentModel)

            }

            }
        }

    }


}
