import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4

Rectangle {
    width:400
    height:600

    Component{
        id:testsForm
        TestsForm{} //κάνε το TestForm

    }

    ListModel{
        id:subjectsListModel //σε αυτό το ListModel θα αποθηκεύουμε { Μάθημα - Μ.Ο Μαθήματος } για όσα μαθήματα προσθέτουμε
                             //περωάμε αυτό το ListModel στο TestsForm (βλ line 279) και εκεί υπολογίζουμε το ΜΟ του μαθήματος απο τα 3 τεστ και επειτα κάνουμε append στη λίστα το ονομα μαθήματος που εισάγαμε και το ΜΟ
    }

    FileDialog{

        id:fileDialog
        title:"select a file"
        nameFilters: [ "Image files (*.jpg *.png)"]
        folder: shortcuts.pictures
        selectFolder:false
        selectMultiple:false
        selectExisting:true
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            student_img.source=fileDialog.fileUrl;
            fileDialog.close();
        }
        onRejected: {
            console.log("Canceled")
            fileDialog.close();
        }
        Component.onCompleted: visible = false

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
                implicitHeight: 40
                border.color: "#58C9B9"
                gradient: Gradient {
                    GradientStop { position: 0 ; color: "#58C9B9" }
                    GradientStop { position: 1 ; color: "#9DC8C8" }
                }
            }
        }//end of style

        Label{
            text:"ΕΙΣΑΓΩΓΗ ΜΑΘΗΤΗ"
            font.family: "comic sans ms"
            anchors.centerIn: parent
            color:"#1f4e5f"
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
        ToolButton{
            anchors.right:parent.right
            id:doneIcon
            width:30
            height:30
            anchors.verticalCenter: parent.verticalCenter
            Image{
                source:"images/sign-check-icon.png"
                anchors.fill:parent
                anchors.margins:2

            }
            onClicked: {
                var A =[]; //εδώ αποθηκεύονται όλα τα ονοματα των μαθημάτων που εισάγαμε για το μαθητη
                var B =[]; //εδώ αποθηκεύονται όλα οι ΜΟ των μαθημάτων που εισάγαμε για το μαθητη
                for(var i=0;i<subjectsListModel.count;i++){
                    A[i]=subjectsListModel.get(i).name_sub;
                    B[i]=subjectsListModel.get(i).mo_sub;
                }
                var mo = m.computeFinalMO(A,B);


                m.insertStudent(nameTextField.text,student_img.source,observationsTextArea.text,mo);
                stack.pop();



            }
        }
    }//end of toolbar

    ColumnLayout {
        id: columnLayout1
        anchors.top:myToolBar.bottom

        width:parent.width
        height:448
    }

    RowLayout {
        id: rowLayout1

        anchors.top:columnLayout1.top
        width:parent.width
        height:68
        Label{
            id:studentNameLabel
            anchors.left:parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text:"Ονομα"
            font.family: "comic sans ms"
            font.bold:true
            color:"black"
            font.pixelSize: 16
        }
        TextField{
            id:nameTextField
            anchors.left:studentNameLabel.right
            anchors.leftMargin: 10
            placeholderText: "Εισαγωγή Ονόματος"
            font.family: "comic sans ms"
            font.pixelSize: 14


        }

    }

    RowLayout {
        id: rowLayout2

        anchors.top:rowLayout1.bottom
        anchors.topMargin:5
        width:parent.width
        height: 109
        Label{
            id:studentPicLabel
            anchors.left:parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text:"Εικόνα"
            font.family: "comic sans ms"
            font.bold:true
            color:"black"
            font.pixelSize: 16
        }
        Rectangle{
            id:studentPicRectangle
            anchors.left:studentPicLabel.right
            anchors.leftMargin:10
            width:100
            height:80
            border.color: "black"
            radius:6
            border.width: 2
            Image{
                id:student_img
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top:parent.top
                anchors.bottom: parent.bottom
                fillMode: Image.PreserveAspectFit
                anchors.margins: 1
            }
        }
        MouseArea{
            id:addImageButton
            anchors.left:studentPicRectangle.right
            anchors.leftMargin: 10
            width:25
            height:25
            Image{
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top:parent.top
                anchors.bottom: parent.bottom
                anchors.margins: 1
                fillMode: Image.PreserveAspectFit
                source:"images/camera.png"

            }
            onClicked:{

               fileDialog.open();
            }
        }

    }

    RowLayout {
        id: rowLayout3

        anchors.top:rowLayout2.bottom
        anchors.topMargin: 5
        width:parent.width
        height: 105
        Rectangle{
            anchors.left: parent.left
            anchors.right:parent.right
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            width:parent.width
            height:parent.height
            border.color: "black"
            border.width: 2
            TextArea{
                id:observationsTextArea
                anchors.fill:parent
                anchors.margins: 2
            }

        }


    }

    RowLayout {
        id: rowLayout4
        anchors.top:rowLayout3.bottom
        anchors.topMargin: 5      
        width:parent.width
      height: 150
        Rectangle{
            anchors.left: parent.left
            anchors.right:parent.right

            anchors.leftMargin: 10
            anchors.rightMargin: 10
            width:parent.width
            height:parent.height
            border.width: 2
            border.color:"black"
            ToolBar{
                id:toolBar2
                height:25
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top:parent.top
                anchors.margins: 3
                style: ToolBarStyle {

                    background: Rectangle {
                        implicitWidth: parent.width
                        implicitHeight: 35
                        border.color: "#58C9B9"
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: "#58C9B9" }
                            GradientStop { position: 1 ; color: "#9DC8C8" }
                        }
                    }
                }//end of style
                Label{
                    text:"Μαθήματα"
                    font.family: "comic sans ms"
                    anchors.centerIn: parent
                    color:"#1f4e5f"
                    font.bold: true
                    font.wordSpacing: 1
                    font.pixelSize: 14
                }
                ToolButton{
                    id:addSubjectButton
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.height
                    height:width
                    Image{
                        source:"images/sign-add-icon.png"
                        anchors.fill: parent
                        anchors.margins: 1
                    }
                    onClicked: {
                        stack.push({item:testsForm, properties:{nameStudent:nameTextField.text,mymodel: subjectsListModel}})
                    }
                }//end of toolbutton 1
                ToolButton{
                    id:deleteSubjectButton
                    anchors.left:parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.height
                    height:width
                    Image{
                        source:"images/del.png"
                        anchors.fill: parent
                        anchors.margins: 1
                    }
                    onClicked:{
                        subjectsListModel.remove(subjects.currentIndex);
                    }

                }//end of delete button

            }//end of toolbar

            Component{
                id: highlightBar
                Rectangle{
                    width:subjects.width
                    height:20
                    color:"lightsteelblue"
                    y: listView.currentItem.y;
                    Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
                }
            }

            ListView{
                id:subjects
                anchors.left:parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top:toolBar2.bottom
                anchors.margins: 5
                model:subjectsListModel
                spacing:5
                highlight:highlightBar
                delegate: Item{
                    height:20
                    width:parent.width
                    Row{
                        spacing:10
                        width:parent.width
                        height:20
                        Label
                        {
                            width:parent.width*0.8
                            text: name_sub //με αυτο το ονομα θα κανουμε append στη λίστα
                            verticalAlignment: Text.AlignVCenter
                        }
                        Label
                        {
                            width:parent.width*0.2
                            text:mo_sub //με αυτο το ονομα θα κανουμε append στη λίστα
                        }
                    }//end of row
                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: subjects.currentIndex = index
                    }
                }//end of item
            }

        }//end of rectangle
    }







}







