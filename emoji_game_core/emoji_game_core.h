//
//  emoji_game_core.h
//  emoji_game_core
//
//  Created by ANDELA on 02/02/2025.
//

#import <Foundation/Foundation.h>

//! Project version number for emoji_game_core.
FOUNDATION_EXPORT double emoji_game_coreVersionNumber;

//! Project version string for emoji_game_core.
FOUNDATION_EXPORT const unsigned char emoji_game_coreVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <emoji_game_core/PublicHeader.h>


/*
 ### **Game Core Logic Specification for Emoji Pair Matching Game**

 #### **1. Game Objective**
 - The player must correctly match related emoji pairs from two columns (left and right).
 - Matching all pairs correctly wins the round; failing results in a new set of emojis.
 - The game increases in difficulty as the player progresses through levels.

 #### **2. Gameplay Mechanics**
 ##### **Emoji Pairing Rules:**
 - The game starts with **3 emojis on the left and 3 on the right**.
 - The player selects an emoji from the left and matches it to one on the right.
 - A match is considered **correct** if it aligns with the predefined answer set.
 - If all pairs are matched correctly, the player wins the round and progresses.
 - If all pairs are matched incorrectly, the player loses and gets a new set of emojis.
 - After **7 successful rounds**, difficulty increases by adding one more pair to each side.

 ##### **Difficulty Progression:**
 | Level | Left Emojis | Right Emojis |
 |--------|------------|-------------|
 | 1      | 3          | 3           |
 | 2      | 3          | 3           |
 | 3      | 3          | 3           |
 | 4      | 3          | 3           |
 | 5      | 3          | 3           |
 | 6      | 3          | 3           |
 | 7      | 3          | 3           |
 | 8      | 4          | 4           |
 | 9      | 5          | 5           |
 | 10     | 6          | 6           |
 | 11+    | 7          | 7           |

 ##### **Game Start & Rounds:**
 - The game generates a **randomized emoji set** for the current level.
 - The player **draws a line or taps** to create a connection between emojis.
 - After each attempt, feedback is provided (correct or incorrect).
 - If the player wins 7 rounds in a row, the **game difficulty increases**.
 - If the player loses a round, a **new emoji set is generated**, but the difficulty remains the same.

 #### **3. Edge Cases & Error Handling**
 1. **Invalid Matches:**
    - If a user tries to match an emoji from the left with one already matched on the right, prevent the action.
    - If a user taps the same emoji twice, no action should be taken.

 2. **Game Progression:**
    - Ensure that after **7 correct rounds**, the number of emojis increases.
    - Ensure the maximum difficulty stops at **7 pairs**.

 3. **Data Source Handling:**
    - If an API is used, handle failed responses gracefully by **fallback to a hardcoded emoji list**.
    - Ensure the same emoji isn’t repeated multiple times in one set.

 4. **Input Handling:**
    - If a user **doesn't complete all matches**, prompt them before moving forward.
    - If a user **closes the app**, save their progress and resume at the same level.

 5. **Performance Considerations:**
    - Optimize emoji rendering and line drawing for smooth UI interactions.
    - Prevent lag when generating new emoji sets.

 #### **4. Win/Loss Conditions**
 ✅ **Win:** If the player correctly matches all pairs in a round.
 ❌ **Loss:** If the player incorrectly matches all pairs in a round.

 Would you like me to refine anything further? 🚀
 */



/*
 ### **Refined Specification for Emoji Pair Matching Game Core Logic**

 ---

 ## **1. Inputs and Outputs**

 ### **Inputs:**
 1. **Emoji Pair Set Generation:**
    - A set of unique emojis for both left and right columns.
    - Emojis are sourced from either an API or a predefined hardcoded list.

 2. **User Actions:**
    - Selecting an emoji from the left column.
    - Selecting an emoji from the right column.
    - Submitting the match.

 3. **Game Progression Triggers:**
    - User makes a correct or incorrect match.
    - User completes all matches in a level.
    - User reaches a new difficulty level after 7 successful rounds.

 ---

 ### **Outputs:**
 1. **Match Result:**
    - ✅ **Correct Match:** If the pair aligns with the predefined answer set, feedback is given, and the match is locked.
    - ❌ **Incorrect Match:** If the pair is incorrect, feedback is provided, and the player continues trying.

 2. **Round Outcome:**
    - 🎉 **Win:** If the player correctly matches all pairs in a level.
    - 🔄 **Loss:** If the player matches all pairs incorrectly, a new set of emojis is generated.

 3. **Game Progression:**
    - If the player wins 7 consecutive rounds, the difficulty increases (one more emoji pair).
    - If the player loses, a new emoji set is generated, but the difficulty remains the same.

 4. **UI Feedback:**
    - Highlight correct or incorrect matches.
    - Display updated score and progression.

 ---

 ## **2. Core Logic Methods**

 ### **Game Initialization & Setup**
 ```swift
 func startNewGame()
 ```
 - **Purpose:** Initializes the game state.
 - **Dependencies:** Calls `generateEmojiPairs(level:)` to fetch emojis.
 - **Output:** Resets scores and starts with the base difficulty (3 pairs).

 ---

 ### **Emoji Pair Generation**
 ```swift
 func generateEmojiPairs(level: Int) -> [(left: String, right: String)]
 ```
 - **Purpose:** Generates a new set of emoji pairs based on the current level.
 - **Input:** `level` (determines the number of pairs, starting from 3).
 - **Output:** Returns an array of emoji pairs.
 - **Edge Cases:**
   - Ensures emojis are unique.
   - Fallback to hardcoded list if API fails.

 ---

 ### **Handling User Match Selection**
 ```swift
 func selectEmojiPair(leftEmoji: String, rightEmoji: String) -> Bool
 ```
 - **Purpose:** Processes user match selection and checks validity.
 - **Input:** The emoji from the left and right column that the user attempts to match.
 - **Output:** Returns `true` if the match is correct, `false` otherwise.
 - **Edge Cases:**
   - Prevents selecting the same emoji twice.
   - Ensures an emoji is not matched more than once.

 ---

 ### **Checking Win/Loss Conditions**
 ```swift
 func checkRoundOutcome() -> RoundResult
 ```
 - **Purpose:** Determines if the player won or lost the round.
 - **Output:** Returns `RoundResult.win` if all matches are correct, `RoundResult.loss` otherwise.
 - **Edge Cases:**
   - If the player gets all matches wrong, resets the round.
   - If all correct, triggers progression to the next round.

 ---

 ### **Handling Difficulty Progression**
 ```swift
 func updateDifficulty()
 ```
 - **Purpose:** Increases difficulty when the player reaches 7 successful rounds.
 - **Dependencies:** Calls `generateEmojiPairs(level:)` with an increased `level`.
 - **Edge Cases:**
   - Ensures level stops at 7 pairs.
   - Prevents skipping difficulty levels.

 ---

 ### **Resetting the Game on Loss**
 ```swift
 func resetRound()
 ```
 - **Purpose:** Resets the current round with a new set of emojis.
 - **Dependencies:** Calls `generateEmojiPairs(level:)`.

 ---

 ## **3. Dependencies**

 ### **Core Dependencies**
 ✅ **Emoji Source:**
    - API call (optional) or hardcoded emoji array.

 ✅ **Game State Management:**
    - Tracks current level, user attempts, and matches.

 ✅ **Randomization Logic:**
    - Ensures a new emoji set every round.

 ✅ **Persistence (Optional):**
    - Saves player progress in case of app closure.

 ---

 ## **4. Summary of Core Methods & Responsibilities**

 | **Method** | **Responsibility** | **Input** | **Output** |
 |------------|-------------------|----------|-----------|
 | `startNewGame()` | Resets the game and starts at level 1 | None | Initializes game state |
 | `generateEmojiPairs(level:)` | Generates emoji pairs for the round | `level` (difficulty) | Returns emoji pair list |
 | `selectEmojiPair(leftEmoji:rightEmoji:)` | Checks if a user-selected pair is correct | Selected emojis | `true` (correct) / `false` (incorrect) |
 | `checkRoundOutcome()` | Determines if the player won or lost the round | None | `RoundResult.win` / `RoundResult.loss` |
 | `updateDifficulty()` | Increases difficulty after 7 successful rounds | None | Increments level and emoji count |
 | `resetRound()` | Resets game state and generates new emojis on loss | None | Generates a new emoji set |

 Would you like to refine anything further? 🚀
 */
