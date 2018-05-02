import QtQuick 2.0

Item {
    id: timer
    property int hh: 0
    property int mm: 0
    property int ss: 0
    property alias ticker: ticker

    Row {
        id: hms
        width: parent.width
        height: parent.height

//        TimeInput {id: curr_hh; width: (parent.width/12)*4; timeText: timer.hh}
//        TimeInput {id: curr_mm; width: (parent.width/12)*4; timeText: timer.mm}
//        TimeInput {id: curr_ss; width: (parent.width/12)*4; timeText: timer.ss}

//        TimeInput {id: curr_hh; timeText: timer.hh}
//        TimeInput {id: curr_mm; timeText: timer.mm}
//        TimeInput {id: curr_ss; timeText: timer.ss}
        Text{
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: timer.hh + ":" + timer.mm + ":" + timer.ss
        }

    }

    Timer {
        id: ticker;
        interval: 1000;
        repeat: true;
        onTriggered: {
            timer.ss--;
            if(timer.ss < 0) {
                timer.ss = 59
                timer.mm--;
                if(timer.mm < 0) {
                    timer.mm = 59
                    timer.hh--;
                    if(timer.hh < 0) {
                        timer.hh = 0
                        // Stops here if there are no more
                        // Ideally set the timer to stop repeating
                        stop()
                    }
                }
            }

        }
    }
}
