'https://developer.roku.com/docs/references/scenegraph/control-nodes/timer.md
sub init()
    m.top.backgroundURI = "pkg:/images/background.jpg"

    print("Stopwatch init")
    m.top.nextScene = "Stopwatch"

    m.top.setFocus(true)
    m.minCounter = 0
    m.counter = 0
    m.hourCounter = 0
    m.label = m.top.findNode("counterLabel")
    m.timer = m.top.findNode("Stopwatch")

    m.state = "down"

    m.timer.ObserveField("fire", "onTimerFire")
    m.timer.control = "start"
end sub

'https://developer.roku.com/en-ca/docs/developer-program/core-concepts/handling-application-events.md
function onKeyEvent(key as String, press as Boolean) as Boolean
    if press and key = "OK"
        print "Stopping Stopwatch"
        m.timer.control = "stop"
        return true
    else if press and key = "back"
        m.top.nextScene = "MainScene"
        m.timer.control = "stop"
        m.cornerVideo = invalid
        return true
    end if
    return false
end function

sub onTimerFire()
    if m.state = "down"
        m.state = "up"
    else if m.state = "up"
        if m.hourCounter >= 23 and m.minCounter >= 59 and m.counter >= 59
            m.label.text = "Stopped at 24 hours"
            m.timer.control = "stop"
        else
            m.counter += 1
    
            if m.counter > 59
                m.counter = 0
                m.minCounter += 1
            end if
    
            if m.minCounter > 59
                m.minCounter = 0
                m.hourCounter += 1
            end if
        end if

        if m.minCounter < 1 and m.hourCounter < 1
            m.label.text = m.counter.ToStr()
        else if m.hourCounter < 1
            m.label.text = m.minCounter.ToStr() + ":" + m.counter.ToStr()
        else
            m.label.text = m.hourCounter.ToStr() + ":" + m.minCounter.ToStr() + ":" + m.counter.ToStr()
        end if

        m.state = "down"
    end if
end sub