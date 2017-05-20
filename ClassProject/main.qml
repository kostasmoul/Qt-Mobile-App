import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
Window {
    visible: true
    width:400
    height:600


    Component{
        id:zero;
        MainForm{}
    }

    StackView
    {
        anchors.fill:parent
        initialItem: zero
        id:stack
    }

    }



