'https://github.com/rokudev/samples/blob/master/ux%20components/lists%20and%20grids/LabelListExample/components/labellistscene.xml
'https://developer.roku.com/en-ca/docs/references/scenegraph/list-and-grid-nodes/labellist.md
'https://developer.roku.com/docs/references/scenegraph/renderable-nodes/poster.md
sub init()
    m.top.backgroundURI = "pkg:/images/background.jpg"
    'overhang = m.top.findNode("overhangLogo")

    mainMenu = m.top.findNode("mainMenu")
    m.top.nextScene = "MainScene"

    rect = mainMenu.boundingRect()
    centerX = (1280 - rect.width) / 2
    centerY = (720 - rect.height) / 2
    mainMenu.translation = [ centerX, centerY ]

    m.mainMenu = mainMenu
    m.top.setFocus(true)
end sub

sub onKeyEvent(key as String, press as Boolean) as Boolean
    if press and key = "OK"
        index = m.mainMenu.itemFocused
        selectedItem = m.mainMenu.content.getChild(index)

        if selectedItem <> invalid
            title = selectedItem.title
            print "Selected item: " + title

            if title = "Start Push-ups"
                print "Requesting PushupScene..."
                m.top.nextScene = "PushupScene" 'this is the thingy for main.brs
                'm.top.close()

            else if title = "Start Squats"
                print "Requesting SquatScene..."
                m.top.nextScene = "SquatScene"

            else if title = "Start Sit-ups"
                print "Requesting SitupScene..."
                m.top.nextScene = "SitupScene"

            else if title = "Start Leg Raises"
                print "Requesting LegRaiseScene..."
                m.top.nextScene = "LegRaiseScene"

            else if title = "Stopwatch"
                print "Requesting Stopwatch..."
                m.top.nextScene = "Stopwatch"

            end if
        end if

        return true
    end if

    return false
end sub