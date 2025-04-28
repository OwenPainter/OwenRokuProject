'https://community.roku.com/t5/Roku-Developer-Program/Global-variables-across-script-and-component/td-p/405444

sub main()
    screen = CreateObject("roSGScreen")
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)
   ' sceneName is just a local variable to this main() method
   sceneName = "MainScene"
  
   while true
    mainScene = screen.CreateScene(sceneName)  'whatever the local variable says is what we will load
    screen.Show()

    ' this loop is where it's stuck as long as the scene is open
    while mainScene.nextScene=sceneName
     '   msg = wait(0, port)
    
      '  if type(msg) = "roSGScreenEvent"
       '     if msg.isScreenClosed()
        '        exit while
         '   end if
       ' end if
    end while
    
    print("here I am")
    sceneName = mainScene.nextScene' this is the line I'm least sure about
    print(sceneName)
    if sceneName = invalid or sceneName = ""
        sceneName = "MainScene"
    end if

    ' now it will loop back to the beginning of this outer while loop where it loads the now changed sceneName.
    end while
end sub
