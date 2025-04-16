sub init()
    m.top.setFocus(true)
    m.counter = 0
    m.label = m.top.findNode("counterLabel")
    m.timer = m.top.findNode("pushupTimer")
    m.audio = m.top.findNode("audioPlayer")
    print "Audio node found: "; (m.audio <> invalid)

    m.state = "down"

    m.timer.ObserveField("fire", "onTimerFire")
    m.timer.control = "start"

    setCornerVideo()
end sub

'corner video code https://developer.roku.com/docs/references/scenegraph/media-playback-nodes/video.md
function setCornerVideo() as void
    videoContent = CreateObject("roSGNode", "ContentNode")
    videoContent.url = "pkg:/sounds/PushupVid.mp4"
    videoContent.title = "Pushup Video"
    videoContent.streamformat = "mp4"

    m.cornerVideo = m.top.findNode("cornerVideo")
    m.cornerVideo.content = videoContent
    m.cornerVideo.loop = true
    m.cornerVideo.control = "play"
    print "Corner video player started."
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press and key = "OK"
        print "Stopping pushup counter"
        m.timer.control = "stop"
        return true
    end if
    return false
end function

sub onTimerFire()
    if m.state = "down"
        print "down"
        if m.audio <> invalid
            m.audio.control = "stop"
            audioContent = CreateObject("roSGNode", "ContentNode")
            audioContent.url = "pkg:/sounds/down.mp3"
            audioContent.streamFormat = "mp3"
            m.audio.content = audioContent
           'm.audio.control = "play"
            print "down command sent"
        else
            print "Error: audio node is not working when playing down"
        end if
        m.state = "up"
    else if m.state = "up"
        print "up"
        if m.audio <> invalid
            m.audio.control = "stop"
            audioContent = CreateObject("roSGNode", "ContentNode")
            audioContent.url = "pkg:/sounds/up.mp3"
            audioContent.streamFormat = "mp3"
            m.audio.content = audioContent
           'm.audio.control = "play"
            print "up command sent"
        else
            print "Error: audio node is not working when playing up"
        end if
        m.counter += 1
        m.label.text = "Push-ups: " + m.counter.ToStr()
        m.state = "down"
    end if
end sub