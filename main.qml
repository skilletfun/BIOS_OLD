import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: root

    property color blue: '#0000cc'
    property color bg: '#cccccc'
    property int current_tab: 0
    property bool flag: true
    property string time: get_time() 

    width: 900
    height: 600
    visible: true
    title: qsTr("BIOS")
    color: bg

    property var dict_keys: {
        '0': ['System Time', 'System Date', ' ', '► Primary IDE Master', '► Primary IDE Slave', ' ', '► SATA 1', '► SATA 2','► SATA 2','► SATA 4', ' ', '► System Information'],
        '1': ['CPU Speed', 'CPU: System Frequency Multiple', 'System/PCI Frequency', 'System/SDRAM Frequency Ratio', ' ', 'CPU Vcore', 'CPU Level 1 Cache', 'CPU Level 2 Cache', 'CPU Level 3 Cache', ' ', 'PS/2 Mouse Function Control', 'USB Legacy Support', 'BIOS Update'],
        '2': ['Suspend Mode', 'Repost Video on S3 Resume', 'ACPI Version', 'ACPI APIC Support', 'CPU Termal Option', 'HDD Power Down'],
        '3': ['Quick Boot', 'Full Screan Logo', 'Bootup Num-Lock', 'Wait For \'F1\' If Error', ' ', '► Boot Device Priority'],
        '4': ['Exit Saving Changes', 'Exit Discarding Changes', 'Load Setup Defaults', 'Discard Changes', 'Save Changes']
    }

    FontLoader { id: mainfont; source: 'font.ttf' }

    Header {
        id: header
        anchors.left: parent.left   
    }

    Rectangle {
        id: mainview
        border.width: 2
        anchors.top: header.bottom
        anchors.bottom: footer.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5
        color: 'transparent'

        property int focus_index: 0

        ListView {
            id: mainlist
            spacing: 5
            height: parent.height
            anchors.top: parent.top
            anchors.topMargin: 25
            anchors.left: parent.left
            anchors.leftMargin: 25
            model: root.dict_keys[String(current_tab)]
            focus: true
            
            delegate: Text {
                color: index == mainlist.currentIndex ? 'white' : blue
                font.family: mainfont.name
                font.pointSize: 12
                text: String(modelData)
            }
            Keys.onReturnPressed: {
                if (flag) check(current_tab, currentIndex);
            }
            Keys.onPressed: {
                if (flag)
                {
                    if (event.key == Qt.Key_Left) current_tab = current_tab > 0 ? current_tab-1 : current_tab;
                    else if (event.key == Qt.Key_Right) current_tab = current_tab < 4 ? current_tab+1 : current_tab;
                    else if (event.key == Qt.Key_Down) currentIndex = String(model[currentIndex+1]) == ' ' ? currentIndex+1 : currentIndex;
                    else if (event.key == Qt.Key_Up) currentIndex = String(model[currentIndex-1]) == ' ' ? currentIndex-1 : currentIndex;
                }
            }
        }

        Column {
            id: valuelist
            anchors.top: parent.top
            anchors.topMargin: 25
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 50
            property var dict_values: {
                '0': ['__TIME__', '__DATE__', '', 'Not Detected', 'Not Detected', '', 'HDD:PM-Hitachi HDT', 'Not Detected', 'Not Detected', 'HDD:3M-ST7236423649S', ''],
                '1': ['1400 MHz', '12.0x', '133/33', 'Auto', '', '1.750V', 'Enabled', 'Enabled', 'Disabled', '', 'Auto', 'Auto', 'Enabled'],
                '2': ['Auto', 'Disabled', 'Disabled', 'Enabled', 'Disabled', 'Disabled'],
                '3': ['Enabled', 'Enabled', 'Disabled', 'Enabled', '', ''],
                '4': ['', '', '', '', '']
            }
            spacing: 5
            Repeater {
                model: parent.dict_values[String(current_tab)]
                Text {
                    color: index == mainlist.currentIndex ? 'white' : blue
                    font.family: mainfont.name
                    font.pointSize: 12
                    text: String(modelData) != '' ? String(modelData) == '__DATE__' ? get_date() : String(modelData) == '__TIME__' ? time :'['+String(modelData)+']' : ' '
                }
            }
        }

        PopupSysInfo { id: info }
        PopupChoice { id: choice }
        PopupMove { id: move }
    }

    Footer {
        id: footer
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }

    function check(tab, index)
    {
        if ((tab == 4) && (index == 0 || index == 1)){ Qt.callLater(Qt.quit); }
        else if (tab == 0 && index == 11){ info.open(); }
        else if (tab == 1 && Array(3,6,7,8, 9, 10, 11).includes(index))
        {
            choice.model = Array('Enabled', 'Disabled', 'Auto');
            choice.open();
        }
        else if (tab == 1 && index == 5)
        {
            choice.model = Array('1.550V', '1.600V', '1.650V', '1.700V','1.750V','1.800V', '1.850V');
            choice.open();
        }
        else if (tab == 2 && index == 0)
        {
            choice.model = Array('S1 (POS) only', 'S3 only', 'Auto');
            choice.open();
        }
        else if ((tab == 2 && Array(1,2,3,4,5).includes(index)) || (tab == 3 && Array(0,1,2,3).includes(index)))
        {
            choice.model = Array('Enabled', 'Disabled');
            choice.open();
        }
        else if (tab == 3 && index == 5)
        {
            move.model = Array('HDD:PM-Hitachi HDT', 'HDD:3M-ST7236423649S');
            move.open();
        }
    }

    function get_date()
    {
        var obj = new Date();
        var month = String(obj.getMonth());
        month = month.length == 1 ? '0' + month : month; 
        return '['+String(obj.getDate())+'.'+month+'.'+String(obj.getFullYear())+']';
    }

    function get_time()
    {
        var obj = new Date();
        var h = String(obj.getHours());
        h = h.length == 1 ? '0' + h : h;
        var m = String(obj.getMinutes());
        m = m.length == 1 ? '0' + m : m;
        var s = String(obj.getSeconds());
        s = s.length == 1 ? '0' + s : s;
        return '['+h+':'+m+':'+s+']';
    }

    function set_value(value)
    {
        var obj = valuelist.dict_values; 
        obj[current_tab][mainlist.currentIndex] = value;
        valuelist.dict_values = obj;
    }

    Timer {
        id: timer
        repeat: true
        onTriggered: { time = get_time(); }
    }

    Component.onCompleted: {
        timer.start();
    }
}