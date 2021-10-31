# Macro Blocks Changelog
## 1.0.1-Release
#### Fixed
- **[ mod ] block now properly shifts adjacent blocks when opened/closed**
- **socket block will not throw errors when toys are dropped on it**

## 1.0.0-Release
#### Added
- **20 blocks for the initial release with many more to come**
- **8 Command blocks**
    - /use & /cast
    - /target, /focus, /cleartarget, /clearfocus
    - /equip, /summonpet

- **6 Condition blocks**
    - [ help ], [ harm ]
    - A configurable [ mod ] block that allows multiple mod keys
    - [ \@ focus ], [ \@ mouseover ], [ \@ cursor ] 
- **4 Utility blocks**
    - #Show, #Showtooltip
    - A newline/return block that creates a new line in the macro and the block stack
    - A **;** (semicolon) block for separating arguments with different conditions in the same command

- **2 User input blocks**
    - A text box for entering custom text (the primary macro text box still works too, obviously)
    - A socket block that accepts dragged and dropped spell, item, toy, pet, and mount buttons

- **Graphical overhaul of many elements in the Macro Frame**
- **Saved Variable storage of account & character macros**
  - This will be utilized for cross-character macro sharing in a future update