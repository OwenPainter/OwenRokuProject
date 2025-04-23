'https://community.roku.com/t5/Roku-Developer-Program/Global-variables-across-script-and-component/td-p/405444

sub main()
    print("inside of main:")

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

'sub main()
    'screen = CreateObject("roSGScreen")
    'port = CreateObject("roMessagePort")
   ' screen.SetMessagePort(port)

   ' sceneName is just a local variable to this main() method
  ' sceneName = "MainScene"
  
   'while true
    'mainScene = screen.CreateScene(sceneName)  'whatever the local variable says is what we will load
    'screen.Show()

    ' this loop is where it's stuck as long as the scene is open
   ' while true
       ' msg = wait(0, port)
       ' if type(msg) = "roSGScreenEvent"
        '    if msg.isScreenClosed()
       '         exit while
      '      end if
     '   end if
    'end while
    'sceneName = mainScene.nextScene ' this is the line I'm least sure about
    'if sceneName = invalid or sceneName = ""
   '     sceneName = "MainScene"
  '  end if
    ' now it will loop back to the beginning of this outer while loop where it loads the now changed sceneName.
 '   end while
'end sub

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
        print("inside of checkNextScene")
        print(m.global)
        print(nextScene)
        sleep(1000)
    end while
end sub
