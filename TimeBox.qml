import QtQuick 2.0
import QtQuick.Controls 1.4
import Material 0.3

Item {
    id: timebox
    anchors.left: parent.left
    anchors.right: parent.right
    height: 40

    Row {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 5

        Rectangle {
            id: name_box_id
            width: (parent.width/12)*4 // col-3
            height: parent.height
            Text {
                id: name
                anchors.fill: parent
                text: name_string
            }
        }

        HMSTimeInput {
            id: hmsTimeInput
            width: (parent.width/12)*4 // col-3
            height: parent.height
            hh: hh_start
            mm: mm_start
            ss: ss_start
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
            text: "Stop"
            onClicked: hmsTimeInput.ticker.stop()
        }
    }
}
