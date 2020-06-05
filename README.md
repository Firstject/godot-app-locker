# Godot App Locker
A tool to lock your game or application made with Godot Engine.

**Minimum version requirement:** Godot v3.2 or above

### How does this work?

**Client**: A client that has this add-on added to the game will be asked for the password before the game can be entered. The password is random by the OS and can't be easily guessed (as the game don't tell that it changes every day). To obtain the password, one must ask the game owner for the code and use it to unlock the game. Once entered, there is no need to do so again when the player re-launch the app.

**Code Spoiler**: A game owner will ask the client for an id given by the app (unique device id). When the game owner acknowledges, they input the code received from the client into their own separate app and bring the output back to the client. The game owner can have the rights to reject it if the client is not allowed to play their game.

### Password Algorithms

These codes are not visible to the client.

```py
app_enc_pass + time + unique_device_id = request_code
```

``unique_pass`` Encryption password for your game.

``time`` Current year concatenated with current month and total days passed, This is used to change the password daily.

``unique_device_id`` ID given from the factory. Android and iOS only.

``request_code`` Code generated from the client. This may be used to convert into an unlockable password used for unlocking the game.

### Use-cases
- Your friends are not a trustworthy
- The player that owns your game in demo version wants to share it to other people by their purposes
- The game owner wants to limit how many people play their game (such as playtesting to find exploits in the game)

### Limitations
- The game owner will have to reply back with a code by number of playtesters. For example, 200 playtesters request for a code, the game owner will have to reply back to 200 playtesters (unless your app does not fix the scope by unique device id).
- Timezone between playtesters and the game owner can vary. This may not be possible if the two are at different continents that may result in a different time from the OS.
- If the unlock code is not used within a day, the client will have to request them again. Equally to the developer, they also have to send the unlock code within a day. 

## How to contribute?
Not applicable.
