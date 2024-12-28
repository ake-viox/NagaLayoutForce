# NagaLayoutForce

Created with inspiration of ActionBarButtonGrowthDirection addon. However that only sets actionbar 1 inverted without editing the .lua / savedvariables.
I prefer all or nothing.

A World of Warcraft addon that automatically inverts all 8 action bars to a Naga-style layout by default.

## Features
- Automatically inverts all action bars (1 through 8).
- Always on if installed, with no in-game configuration or commands.

## Installation

1. **Download** or clone this repository to your computer.
2. Rename the folder to `NagaLayoutForce` if it isn’t already.
3. Place it in your WoW AddOns directory:
   ```
   \World of Warcraft\_retail_\Interface\AddOns
   ```
4. **Restart WoW** or type `/reload` in chat if you’re already in-game.
5. Ensure the addon **NagaLayoutForce** is enabled in the WoW AddOns list before logging in.

## How It Works

- The addon utilizes a hooking mechanism (method=2) to modify the layout of all action bars on the Y-axis.
- By default, all bars are set to naga orientation.
- Changes persist through UI updates with Edit Mode.

## Known behavior issues

This is more of a visual issue if you come from an addon:

- If you had Elvui installed and did not reverse all bars in their config then you will see it inverted. After setting it to your liking once with the default WoW bars it will show correct.
- Make sure no other actionbar altering addons are installed.

## Editing Behavior (Advanced Users)

If you wish to modify the default behavior, you can edit the `NagaLayoutForce.lua` file:

- Adjust the `defaults` table to change how bars are handled.
- Modify the `map` table if additional (or less) bars need to be supported.

## Note

This addon will not be maintained.
Fork the git, add a zipped release and you can use it in a download manager like WowUp.

## Screenshots

- Default
![Default](https://github.com/ake-viox/NagaLayoutForce/blob/main/media/default.png?raw=true)

- Naga Layout
![Naga](https://github.com/ake-viox/NagaLayoutForce/blob/main/media/naga.png?raw=true)