import QtQuick 2.12
import QtQuick.Controls 2.12


Popup {
    id: root
    
    focus: true
    anchors.centerIn: parent
    width: 350
    padding: 0
    background: Rectangle { color: 'transparent' }
    
    property alias model: rep.model

    onOpened: { flag = false; }
    onClosed: { flag = true; mainlist.focus = true; rep.currentIndex = 0;}

    Rectangle {color: 'black'; width: parent.width; height: parent.height}
    Rectangle {color: bg; width: 10; height: 10; anchors.top: parent.top; anchors.right: parent.right}
    Rectangle {color: bg; width: 10; height: 10; anchors.left: parent.left; anchors.bottom: parent.bottom}
    
    Rectangle {
        color: blue
        width: parent.width-10
        height: rep.height + 30
        Rectangle { border.color: bg; border.width: 1; color: 'transparent'; anchors.fill: parent; anchors.margins: 5}    
        ListView {
            id: rep
            height: contentHeight
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5
            focus: true
                
            delegate: Text {
                color: index == rep.currentIndex ? 'white' : bg
                font.family: mainfont.name
                font.pointSize: 12
                text: modelData
            }
            
            Keys.onPressed: {
                if (event.key == Qt.Key_F5) {
                    if (rep.currentIndex > 0)
                    {
                        var obj = rep.model;
                        obj[rep.currentIndex] = rep.model[rep.currentIndex-1];
                        obj[rep.currentIndex-1] = rep.model[rep.currentIndex];
                        rep.model = obj; 
                    }
                }
                if (event.key == Qt.Key_F6) {
                    if (rep.currentIndex == 0)
                    {
                        var obj = rep.model;
                        obj[rep.currentIndex] = rep.model[rep.currentIndex+1];
                        obj[rep.currentIndex+1] = rep.model[rep.currentIndex];
                        rep.model = obj; 
                    }
                }
            }
            
            Keys.onReturnPressed: {
                root.close();
            }
        }
    }
}