import QtQuick 2.12
import QtQuick.Controls 2.12


Rectangle {
    width: parent.width
    height: 24
    color: blue
    Row {
        anchors.leftMargin: 5
        anchors.fill: parent
        BIOSButton {
            index: 0
            _text: 'Main'
        }
        BIOSButton {
            index: 1
            _text: 'Advanced'
        }
        BIOSButton {
            index: 2
            _text: 'Power'
        }
        BIOSButton {
            index: 3
            _text: 'Boot'
        }
        BIOSButton {
            index: 4
            _text: 'Exit'
        }
    }
}