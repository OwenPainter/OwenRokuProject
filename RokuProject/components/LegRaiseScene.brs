sub init()
    m.top.backgroundURI = "pkg:/images/background.jpg"

    print("LegRaiseScene init")
    m.top.nextScene = "LegRaiseScene"

    m.top.setFocus(true)
    m.counter = 0
    m.label = m.top.findNode("counterLabel")
    m.timer = m.top.findNode("pushupTimer")
    'm.audio = m.top.findNode("audioPlayer")
    print "Audio node found: "; (m.audio <> invalid)

    m.state = "down"

    m.timer.ObserveField("fire", "onTimerFire")
    m.timer.control = "start"

    setCornerVideo()
end sub

'corner video code https://developer.roku.com/docs/references/scenegraph/media-playback-nodes/video.md
function setCornerVideo() as void
    videoContent = CreateObject("roSGNode", "ContentNode")
    videoContent.url = "pkg:/sounds/LegRaise1.mp4"
    videoContent.title = "Pushup Video"
    videoContent.streamformat = "mp4"

    m.cornerVideo = m.top.findNode("cornerVideo")
    m.cornerVideo.content = videoContent
    m.cornerVideo.loop = true
    m.cornerVideo.control = "play"
    print "Corner video player started."
end function

'https://developer.roku.com/en-ca/docs/developer-program/core-concepts/handling-application-events.md
function onKeyEvent(key as String, press as Boolean) as Boolean
    if press and key = "OK"
        print "Stopping leg raise counter"
        m.timer.control = "stop"
        return true
    else if press and key = "back"
        m.top.nextScene = "MainScene"
        m.timer.control = "stop"
        m.cornerVideo.control = "stop"
        m.cornerVideo = invalid
        return true
    end if
    return false
end function

sub onTimerFire()
    if m.state = "down"
        print "down"
        m.state = "up"
    else if m.state = "up"
        print "up"
        m.counter += 1
        m.label.text = "Leg Raises: " + m.counter.ToStr()
        m.state = "down"
    end if
end sub