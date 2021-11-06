# Macro Blocks Changelog
### 1.3.0-Release
#### Fixed

#### Added
- Slash commands added by Addons are now archived

### 1.2.1-Release
#### Fixed
- Corrected tooltip spelling errors
- Corrected additional spaces in macro text breaking logic blocks

### 1.2.0-Release
#### Fixed
- Elements of the original MacroFrame should no longer appear

#### Added
- All blocks now show info tooltips when 'shift' is held
- 2 New Condition Blocks
  - specialization selection & talent selection
- 1 New Logic Block
  - true '[]'

### 1.1.0-Release
#### Fixed
- Extra spaces in macro text

#### Added
- 4 Command blocks
  - /equipset, /equipslot, /targetfriend, /targetenemy
- 3 Condition blocks
  - combat, exists, dead
- 2 Condition modifier blocks
  - no, & (and)
- 6 Target blocks
  - moved: \@mouseover, \@cursor, \@focus to new target group
  - new: \@player, \@target, \@pet

#### Removed
- /summonpet (will return with the release of the advanced block palette)

### 1.0.2-Release
#### Fixed
- Multiple socket blocks, edit blocks, or mod blocks will no longer overwrite each other

### 1.0.1-Release
#### Fixed
- [ mod ] block now properly shifts adjacent blocks when opened/closed
- socket block will not throw errors when toys are dropped on it

### 1.0.0-Release
#### Added
- 20 blocks for the initial release with many more to come
- 8 Command blocks
    - /use & /cast
    - /target, /focus, /cleartarget, /clearfocus
    - /equip, /summonpet

- 6 Condition blocks
    - [ help ], [ harm ]
    - A configurable [ mod ] block that allows multiple mod keys
    - [ \@ focus ], [ \@ mouseover ], [ \@ cursor ] 
- 4 Utility blocks
    - #Show, #Showtooltip
    - A newline/return block that creates a new line in the macro and the block stack
    - A **;** (semicolon) block for separating arguments with different conditions in the same command

- 2 User input blocks
    - A text box for entering custom text (the primary macro text box still works too, obviously)
    - A socket block that accepts dragged and dropped spell, item, toy, pet, and mount buttons

- Graphical overhaul of many elements in the Macro Frame
- Saved Variable storage of account & character macros
  - This will be utilized for cross-character macro sharing in a future update