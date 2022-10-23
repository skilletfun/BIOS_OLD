import QtQuick 2.12
import QtQuick.Controls 2.12


Rectangle {
    height: 52
    color: '#33cccc'

    Row {
        anchors.topMargin: 4
        anchors.leftMargin: 20
        anchors.fill: parent
        spacing: 50
        Repeater {
            model: [
                ['F1', 'EXC', 'Help', 'Exit'], 
                ['↕', '↔', 'Select Item', 'Select Menu'],
                ['-/+', 'Enter', 'Change Values', 'Select Sub Menu'],
                ['F9', 'F10', 'Setup Defaults', 'Save And Exit']
            ]
            Row {
                spacing: 20
                Repeater {
                    model: Array(modelData)
                    Column {
                        Text {
                            height: 24
                            color: 'white'
                            font.family: mainfont.name
                            font.pointSize: 12
                            text: modelData[0]
                        }
                        Text {
                            height: 24
                            color: 'white'
                            font.family: mainfont.name
                            font.pointSize: 12
                            text: modelData[1]
                        }
                    }
                }
                Repeater {
                    model: Array(modelData)
                    Column {
                        Text {
                            height: 24
                            font.family: mainfont.name
                            font.pointSize: 12
                            text: modelData[2]
                        }
                        Text {
                            height: 24
                            font.family: mainfont.name
                            font.pointSize: 12
                            text: modelData[3]
                        }
                    }
                }
            }
        }
    }
}