import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.Shapes 1.0
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


        Shape {
            width: 100
            height: 100
            anchors.centerIn: parent

            Rectangle {
                z: -1
                anchors.centerIn: parent
                property int shrink_value: 10
                width: parent.width-shrink_value; height: parent.height-shrink_value;
                radius: width*0.5
                color: "#0285CD"
            }

            ShapePath {
                id: timeArc
                property int radius: 50
                // Radius values going to be equivalent to center
                property int centerx: timeArc.radius
                property int centery: timeArc.radius
                property int percentage: 0
                property double raw_degrees: percentage * (360/100)
                // Degrees need to be shifted by 90 degrees so rotation starts at top instead of right
                property double degrees: raw_degrees -90
                property double radians: degrees*(Math.PI/180)
                strokeColor: "#3B4CA9"
                fillColor: "#3B4CA9"
                dashPattern: [ 1, 4 ]
                startX: timeArc.centerx; startY: 0
                PathLine { x: timeArc.centerx; y: timeArc.centery}
                PathLine {
                    id: pathLine
                    x: -(timeArc.radius*Math.cos(timeArc.radians)) + timeArc.radius;
                    y: timeArc.radius*Math.sin(timeArc.radians) + timeArc.radius;
                }
                PathArc {
                    x: timeArc.startX; y: timeArc.startY
                    radiusX: timeArc.radius; radiusY: timeArc.radius
                    direction: PathArc.Clockwise
                    // Important to modulate degrees variable to make sure useLargeArc works properly
                    // Use raw_degrees, as degrees is used to change orientation
                    useLargeArc: (timeArc.raw_degrees % 360) < 180 ? false : true
                }
            }
            Component.onCompleted:  {
                console.log(pathLine.x + ":" + pathLine.y)
                ticker.start()
            }
            Timer {
                id: ticker;
                interval: 1;
                repeat: true;
                onTriggered: {
                    timeArc.percentage += 1
                }
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

        // Only used for debuging:
        //        Component.onCompleted: listModel.append (
        //                                   {
        //                                hh_start: "0",
        //                                mm_start: "0",
        //                                ss_start: "10",
        //                                name_string: "test",
        //                                   })
        //    }
    }

}
