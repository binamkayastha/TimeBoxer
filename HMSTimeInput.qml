import QtQuick 2.0

Item {
    id: timer
    property int initial_hh: 0
    property int initial_mm: 0
    property int initial_ss: 0
    property int hh: initial_hh
    property int mm: initial_mm
    property int ss: initial_ss
    property alias ticker: ticker
    property CountdownCircle countdownCircle

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
            var init_total_sec = (timer.initial_hh*60*60 + timer.initial_mm*60 + timer.initial_ss)
            var curr_total_sec = (timer.hh*60*60 + timer.mm*60 + timer.ss)
            var percentage =
                    (init_total_sec - curr_total_sec)
                    /(init_total_sec)
                    *99.99
            countdownCircle.percentage = percentage

        }
    }
}
