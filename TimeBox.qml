import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Material 0.3

Item {
    id: timebox
    anchors.left: parent.left
    anchors.right: parent.right
    height: 50

    signal removed()

    RowLayout {
        id: timeboxRow
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height
        spacing: 5

        CountdownCircle {
            id: countdownCircle
            Layout.leftMargin: 10
            height: parent.height -5
            width: height
        }

        HMSTimeInput {
            id: hmsTimeInput
            width: dp(50) // col-3
            height: parent.height
            initial_hh: hh_start
            initial_mm: mm_start
            initial_ss: ss_start
            countdownCircle: countdownCircle
        }

        Rectangle {
            id: name
            Layout.fillWidth: true
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
            text: "Start"
            // By clicking on the button in the text box we return the index in the ListView
            onClicked: {
                onClicked: hmsTimeInput.ticker.start()
            }
        }
        Button {
            id: stop
            Layout.rightMargin: 0
            text: "Stop"
            onClicked: hmsTimeInput.ticker.stop()
        }
        Button {
            id: remove
            text: "Delete"
            onClicked: {
                removed()
            }
        }

    }
}
