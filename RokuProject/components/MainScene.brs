'https://github.com/rokudev/samples/blob/master/ux%20components/lists%20and%20grids/LabelListExample/components/labellistscene.xml
'https://developer.roku.com/en-ca/docs/references/scenegraph/list-and-grid-nodes/labellist.md

sub init()
    'm.top.backgroundURI = "pkg:/images/rsgde_bg_hd.jpg"

    m.top.nextScene = invalid

    mainMenu = m.top.findNode("mainMenu")

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

            else if title = "Another Option"
                print "Doing something else..."
            end if
        end if

        return true
    end if

    return false
end sub

