import QtQuick 2.5
import QtQuick.Controls 1.4
import Material 0.3
//import QtQuick.Controls.Material 2.1

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Timeboxer")

//    Material.theme: Material.Dark
//    Material.accent: Material.Purple


    Row {
        id: topbar
        height: 50
        spacing: 5
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        Rectangle {
            width: (parent.width/2) // col-6
            height: parent.height

            TextEdit {
                id: nameinput
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                property string placeholderText: "Enter text here..."

                Text {
                    anchors.fill: parent
                    verticalAlignment: parent.verticalAlignment
                    horizontalAlignment: parent.horizontalAlignment
                    text: nameinput.placeholderText
                    color: "#aaa"
                    visible: !nameinput.text
                }
                // Key navigation settings have to be here, because textedit captures input first
                KeyNavigation.priority: KeyNavigation.BeforeItem
                KeyNavigation.tab: hh_input
            }
        }
        // Each TimeInput is width col-1
        TobbarTimeInput {id: hh_input; KeyNavigation.tab: mm_input; KeyNavigation.backtab: nameinput;}
        TobbarTimeInput {id: mm_input; KeyNavigation.tab: ss_input; KeyNavigation.backtab: hh_input;}
        TobbarTimeInput {id: ss_input; KeyNavigation.tab: add_timebox; KeyNavigation.backtab: mm_input;}

        // col-3
        Button {
            id: add_timebox
            text: qsTr("Add Timebox")
            width: (parent.width / 12)*3
            height: parent.height

            onClicked: {
                listModel.append(
                            {
                                hh_start: hh_input.text,
                                mm_start: mm_input.text,
                                ss_start: ss_input.text,
                                name_string: nameinput.text,
                            })
            }
            KeyNavigation.backtab: ss_input
        }

    }

    ListView {
        id: boxlist
        anchors.top: topbar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        model: ListModel {
            id: listModel
        }
        delegate: TimeBox {}
    }
}

