'https://community.roku.com/t5/Roku-Developer-Program/Global-variables-across-script-and-component/td-p/405444

sub main()
    print(m.global)

    if m.global = "0"
        m.global = "1"
    end if
    
    if m.global = invalid
        m.global = "0"
    end if

    screen = CreateObject("roSGScreen")
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)

    if m.global = "0"
        mainScene = screen.CreateScene("MainScene")
        screen.Show()
    else if m.global = "1"
        mainScene = screen.CreateScene("PushupScene")
        screen.Show()
    end if

    checkNextScene(mainScene)

    while true
        msg = wait(0, port)

        if type(msg) = "roSGScreenEvent"
            if msg.isScreenClosed()
                exit while
            end if
        end if

    end while
end sub

sub checkNextScene(scene as Object)
    while true
        nextScene = scene.nextScene

        if nextScene = "PushupScene"
            print "YEP"
            m.global = "1"
            main()
            'exit while
        else if nextScene = invalid
            m.global = "0"
        end if

        print(m.global)
        sleep(1000)
    end while
end sub

