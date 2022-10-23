import QtQuick 2.12
import QtQuick.Controls 2.12


Button {
    id: root
    
    property int index: 0
    property string _text: '' 

    height: 24
    width: 150
    
    background: Rectangle { color: root.index == current_tab ? bg : 'transparent' }
    
    contentItem: Text {
        text: root._text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: mainfont.name
        font.pointSize: 12
        color: parent.index == current_tab ? blue : bg
    }

    onClicked: {
        current_tab = index;
    }
}