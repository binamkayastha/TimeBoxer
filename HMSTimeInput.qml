import QtQuick 2.0

Item {
    id: timer
    property int hh: 0
    property int mm: 0
    property int ss: 0
    property alias ticker: ticker

    width: parent.width
    height: parent.height
    Text{
        anchors.centerIn: parent
        text: timer.hh + ":" + timer.mm + ":" + timer.ss
    }


    Timer {
        id: ticker;
        interval: 1000;
        repeat: true;
        onTriggered: {
            timer.ss--;
            if(timer.ss < 0) {
                timer.mm--;
                timer.ss = 59
                if(timer.mm < 0) {
                    timer.mm = 59
                    timer.hh--;
                    if(timer.hh < 0) {
                        timer.hh = 0
                        timer.mm = 0
                        timer.ss = 0
                        // Stops here if there are no more
                        // Ideally set the timer to stop repeating
                        stop()
                    }
                }
            }

        }
    }
}
