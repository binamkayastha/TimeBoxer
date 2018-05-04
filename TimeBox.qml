import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Material 0.3

Item {
    id: timebox
    anchors.left: parent.left
    anchors.right: parent.right
    height: 70

    signal removed()

    RowLayout {
        id: timeboxRow
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 5

        HMSTimeInput {
            id: hmsTimeInput
            Layout.alignment: Qt.AlignLeft
            width: dp(50) // col-3
            height: parent.height
            hh: hh_start
            mm: mm_start
            ss: ss_start
        }

        Rectangle {
            id: name
            Layout.alignment: Qt.AlignLeft
            color: "transparent"
            width: (parent.width/12)*4 // col-3
            height: parent.height
            Label {
                anchors.centerIn: parent
                fontStyles: "display1"
                text: name_string
            }
        }

        Button {
            id: start
            anchors.right: stop.left
            text: "Start"
            // By clicking on the button in the text box we return the index in the ListView
            onClicked: {
                onClicked: hmsTimeInput.ticker.start()
            }
        }
        Button {
            id: stop
            anchors.right: remove.left
            Layout.rightMargin: 0
            text: "Stop"
            onClicked: hmsTimeInput.ticker.stop()
        }
        Button {
            id: remove
            Layout.alignment: Qt.AlignRight
            text: "Delete"
            onClicked: {
                removed()
            }
        }

    }
}
