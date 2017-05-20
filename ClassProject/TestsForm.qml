import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2

Rectangle{
    width:400
    height:600

    property ListModel mymodel
    property string nameStudent

    ToolBar
    {
        id:subjectsToolBar


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
            text:"Εισαγωγή Μαθήματος"

            anchors.centerIn: parent
            color:"#1f4e5f"
            font.family: "comic sans ms"
            font.bold: true
            font.wordSpacing: 1
            font.pixelSize: 18

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
        ToolButton{
            anchors.right:parent.right
            id:doneButton
            width:30
            height:30
            anchors.verticalCenter: parent.verticalCenter
            Image{
                source: "images/sign-check-icon.png"
                anchors.fill: parent
                anchors.margins:2
            }
            onClicked:{
                m.insertSubject(name.text,nameStudent,t1SpinBox.value,t2SpinBox.value,t3SpinBox.value); // κάνουμε insert το μάθημα στο subjectModel για να μπορει να συνδέσει το όνομα του μαθήματος,που θα βρίσκεται πλέον στο μοντελο, με τον mo που δίνουμε για να μπορει να κάνει convert τις δύο QVariantList με τα ονοματα και τους μ.ο.( Α[] και Β[] στο InsertStudentForm) σε ένα vector (βλ. convert function in subjectmodel.cpp)..αφου τα κάνει convert θα μπορούμε να καλούμε το getMO()(βλ. student.cpp) για να μπορούμε να υπολογίζουμε το ΜΟ όλων των μαθημάτων του μαθητή
                mymodel.append({"name_sub":name.text,"mo_sub":moResult.text }) //εδώ κάνει append στο ListModel που βρίσκεται στο InsertStudentForm
                stack.pop();
            }
        }
    }



    TextField{
        id:name
        anchors.top:subjectsToolBar.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        placeholderText: "Όνομα μαθήματος"
        font.family: "comic sans ms"
        font.wordSpacing: 1
        font.pixelSize: 14

    }

    Column{
        width:parent.width
        height:parent.height
        anchors.top:name.bottom
        anchors.topMargin: 40
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right:parent.right
        spacing:20
        Row{
            id:row1
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:10
            Label{
                text:"TEST 1"
                font.bold: true
            }
            SpinBox{
                id:t1SpinBox


                height:30
                font.family: "comic sans ms"
                font.wordSpacing: 1
                font.pixelSize: 14
                minimumValue: 0
                maximumValue: 10
                decimals:1


            }
        }

        Row{
            id:row2
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:10
            Label{
                text:"TEST 2"
                font.bold: true
            }
            SpinBox{
                id:t2SpinBox


                height:30
                font.family: "comic sans ms"
                font.wordSpacing: 1
                font.pixelSize: 14
                minimumValue: 0
                maximumValue: 10
                decimals:1


            }
        }
        Row{
            id:row3
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:10
            Label{
                text:"TEST 3"
                font.bold: true
            }
            SpinBox{
                id:t3SpinBox


                height:30
                font.family: "comic sans ms"
                font.wordSpacing: 1
                font.pixelSize: 14
                minimumValue: 0
                maximumValue: 10
                decimals:1


            }
        }
        Row{
            id:row4
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:10


            Button {

                ColorAnimation {
                    from: "white"
                    to: "black"
                    duration: 200
                }
                id: calculate
                text: qsTr("ΥΠΟΛΟΓΙΣΜΟΣ Μ.Ο.")


                onClicked: {

                    moResult.text = Number((t1SpinBox.value + t2SpinBox.value + t3SpinBox.value)/3).toPrecision(2)
                }
            }


        }
        Row{
            id:row5
            anchors.horizontalCenter: parent.horizontalCenter

            spacing:10
            Label{

                id:moResult
                font.family: "comic sans ms"
                font.wordSpacing: 1
                font.pixelSize: 16
                font.bold: true

            }

        }


    }






}
