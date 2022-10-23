import QtQuick 2.12
import QtQuick.Controls 2.12

Popup {
    anchors.centerIn: parent
    height: parent.height - 4
    width:parent.width - 4
    background: Rectangle { color: bg }

    onOpened: { flag = false; }
    onClosed: { flag = true; }

    Item {
        anchors.fill: parent
        anchors.margins: 5
        Column {
            spacing: 5
            Text {
                color: 'black'
                text: 'Bios Information'
                font.family: mainfont.name
                font.pointSize: 12
            }
            Text {
                color: 'grey'
                text: 'Version\t: 0133'
                font.family: mainfont.name
                font.pointSize: 12
            }
            Text {
                color: 'grey'
                text: 'Build Date\t: 03/07/12'
                font.family: mainfont.name
                font.pointSize: 12
            }
            Text {
                text: ' '
                font.family: mainfont.name
                font.pointSize: 12
            }
            Text {
                color: 'black'
                text: 'Processor'
                font.family: mainfont.name
                font.pointSize: 12
            }
            Text {
                color: 'grey'
                text: 'Type\t: Intel(R) Core(TM) 2 DUO CPU E7500'
                font.family: mainfont.name
                font.pointSize: 12
            }
            Text {
                color: 'grey'
                text: 'Speed\t: 2933MHz'
                font.family: mainfont.name
                font.pointSize: 12
            }
            Text {
                text: ' '
                font.family: mainfont.name
                font.pointSize: 12
            }
            Text {
                color: 'black'
                text: 'System Memory'
                font.family: mainfont.name
                font.pointSize: 12
            }
            Text {
                color: 'grey'
                text: 'Installed Size\t:\t2048MB'
                font.family: mainfont.name
                font.pointSize: 12
            }
            Text {
                color: 'grey'
                text: 'Available Size\t:\t2014MB'
                font.family: mainfont.name
                font.pointSize: 12
            }
        }
    }
}