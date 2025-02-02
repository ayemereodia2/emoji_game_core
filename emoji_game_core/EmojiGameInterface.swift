//
//  EmojiGameInterface.swift
//  emoji_game_core
//
//  Created by ANDELA on 02/02/2025.
//

import Foundation

public protocol EmojiGameInterface {
  func startGame()
  func generateNewEmojiPairs(level: Int)
  func selectEmojiPair(left: Emoji, right: Emoji) -> CurrentPairingMoveResult
  func hasUserWonCurrentPlay() -> CurrentPlayResult
  func fetchCurrentLevelEmojiCount() -> Int
  func increaseDifficulty()
  func resetGame()
  func saveGame()
  func nextStage()
}

protocol EmojiPairGenerator {
  func generateNewEmojiPairs(level: Int) -> [Emoji]
}
