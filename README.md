# NagaLayoutForce

Created with your friendly neighborhood AI.

A World of Warcraft addon that automatically inverts all 8 action bars to a Naga-style layout by default. This addon uses a hooking mechanism to ensure the layout persists even when the bars are edited in-game.

## Features
- Automatically inverts all action bars (1 through 8).
- Uses a hooking method to apply changes consistently whenever the game updates the action bars.
- Simplified approach with no in-game configuration or commands.

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
- By default, all bars are set to vertical orientation, and no horizontal toggling is allowed.
- Changes persist through UI updates without user intervention.

## Technical Details

- The addon maps Blizzard bar frame names (e.g., `MainMenuBar`, `MultiBarBottomLeft`) to ensure compatibility with WoW's default action bars.
- On addon load, it initializes the vertical layout and applies the changes via hooking to ensure the layout persists during gameplay.

## Editing Behavior (Advanced Users)

If you wish to modify the default behavior, you can edit the `NagaLayoutForce.lua` file:

- Adjust the `defaults` table to change how bars are handled.
- Modify the `map` table if additional (or less) bars need to be supported.