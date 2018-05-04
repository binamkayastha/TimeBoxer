import QtQuick 2.0
import QtQuick.Shapes 1.0

Item {
    Shape {
        id: shape
        height: parent.height
        width: height
        anchors.centerIn: parent

        Rectangle {
            id: bg_circle
            z: -1
            anchors.centerIn: parent
            property int shrink_value: 10
            width: shape.width-shrink_value; height: shape.height-shrink_value;
            radius: width*0.5
            color: "#0285CD"
        }

        ShapePath {
            id: timeArc
            property int radius: shape.width/2
            // Radius values going to be equivalent to center
            property int centerx: timeArc.radius
            property int centery: timeArc.radius
            property int percentage: 0
            property double raw_degrees: percentage * (360/100)
            // Degrees need to be shifted by 90 degrees so rotation starts at top instead of right
            property double degrees: raw_degrees -90
            property double radians: degrees*(Math.PI/180)
            strokeWidth: 0
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

}
