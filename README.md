**COMING SOON**
**Preview : [Video](https://youtu.be/XBZ9XU-3Qck)**

<h1 align="center">Codex Police Find Player [vRP] </h1>

* Hello There 👋. This is a FiveM resource where players can find information about other players using a licence plate and track them in real time! ⬇️

![image](https://user-images.githubusercontent.com/70026038/153661932-267b6eb6-9b33-470c-b455-f0666cf39947.png)

* Once a player has inputed ⌨️ the licence plate of a vehicle, and clicked on get info, the user is then prompted with information about the player! ⬇️

![image](https://user-images.githubusercontent.com/70026038/153661977-9e68f346-4a5b-4f63-92f9-71b1535da93f.png)

* Finally, if the user selects the `TRACK` button, then a constant waypoint will be set on the player! ⬇️

![image](https://user-images.githubusercontent.com/70026038/152690749-25fd4dfb-8da5-4f2d-882c-aba538344cb4.png)

* TIP : 💡 Don't forget to edit your menu coords and police group permission in the config.lua file! ⬇️

```
Config = {
    menuCoords = {
        {-455.93838500976,-2810.7602539062,7.2959337234498} -- Menu spawn coords!
    },
    menuMarker = 6,-- Marker to be shown at menu spawn point - https://docs.fivem.net/docs/game-references/markers/
    menuOpenButton = 38, -- Button to open menu (38 = "E") - https://docs.fivem.net/docs/game-references/controls/
    policeGroup = "police.member", -- Permission needed in vrp/cfg/groups.lua to access the menu
    openMenuText = "Press E to open the menu!", -- Message displayed to player to open the menu
    errorTextDetails = "No details about the user have been entered!", -- Error for not inputing details about the player
    trackSuccessMessage = "The person has been tracked successfully!", -- Message for successful tracking!
    cantTrackYourself = "You cannot track yourself on the map!", -- Error for not traking yourself!
    noAccessToCommand = "You do not have access to this command!", -- Error for no access to menu!
    licenceNotFound = "This licence plate was not found in our database!", -- Error for when a vehicles licence is not found in DB
    displayNotiTime = 5000, -- Time to display notification in miliseconds!
    trackOffMessage = "The person has been unmarked from the map!", -- Message for unmarking a player off the map!
}

-- Remember! You can use '~p~' etc. to style the openMenuText !

```

<h2 align="center">What to expect in the future?</h2>

```
In the next version expect the following:

- New UI (Animations, Design etc.)
- More custom sounds
- Optimization 
- See number of cars player owns

If you have any other suggestions add me on discord codex.exe#0001 !
```




<h3 align="center">Dependencies</h3>

* [okokNotify](https://forum.cfx.re/t/okoknotify-standalone-paid/3907758) - Custom Notifications! Credits okok
* [vRP_findPlayer](https://github.com/DGVaniX/vRP/tree/master/vrp_findPlayer) - Script to track and find the player from their source! Credits @DGVanix


**FOR ANY BUSINESS ENQUIRIES/SUPPORT/SUGGESTIONS DM ME ON DISCORD - codex.exe#0001**


<h6>Current Version : 1.0.0</h6>
