import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import Material 0.3
import Material.Extras 0.1
//import QtQuick.Controls.Material 2.1

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Timeboxer")

    theme {
        primaryColor: "#3E4FB1"
        accentColor: "red"
        tabHighlightColor: "white"
    }


    initialPage: Page {
        title: "TimeBoxer"

        ListView {
            id: boxlist
            anchors.fill: parent

            model: ListModel {
                id: listModel
            }
            delegate: TimeBox {
                onRemoved: listModel.remove(index)
            }
        }


        ActionButton {
            anchors {
                right: parent.right
                bottom: parent.bottom
                margins: dp(32)
            }

            action: Action {
                id: addContent
                text: "&Add"
                shortcut: "A"
                onTriggered: {
                    addTimeboxPrompt.open()
                }
            }
            iconName: "content/add"
        }

        Dialog {
            id: addTimeboxPrompt
            width: dp(300)
            text: "Create a new Timebox!"
            hasActions: true
            positiveButtonEnabled: true
            negativeButtonText: "Cancel"
            positiveButtonText: "Add"
            TextField {
                id: nameInput
                width: parent.width
                placeholderText: "Name of Timebox"
            }
            Row {
                width: parent.width
                TextField {
                    id: hh_input;
                    width: parent.width/3
                    placeholderText: "hh"
                }
                Text {
                    text: ":"
                }
                TextField {
                    id: mm_input;
                    width: parent.width/3
                    placeholderText: "mm"
                }
                Text {
                    text: ":"
                }
                TextField {
                    id: ss_input;
                    width: parent.width/3
                    placeholderText: "ss"
                }

            }

            onAccepted: {
                // Add an item
                listModel.append(
                            {
                                hh_start: hh_input.text,
                                mm_start: mm_input.text,
                                ss_start: ss_input.text,
                                name_string: nameInput.text,
                            })
                // Clear text
                nameInput.text = ""
                hh_input.text = ""
                mm_input.text = ""
                ss_input.text = ""
            }
            onRejected: {
                // Clear text
                nameInput.text = ""
                hh_input.text = ""
                mm_input.text = ""
                ss_input.text = ""
            }
        }

        //         Only used for debuging:
        Component.onCompleted: listModel.append ([
                                 {
                                     hh_start: "0",
                                     mm_start: "0",
                                     ss_start: "10",
                                     name_string: "test",
                                 },
                                 {
                                     hh_start: "0",
                                     mm_start: "0",
                                     ss_start: "10",
                                     name_string: "test",
                                 },
                             ])
    }
}

