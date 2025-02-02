//
//  Game.swift
//  emoji_game_core
//
//  Created by ANDELA on 02/02/2025.
//

import Foundation

public class Game: EmojiGameInterface {
  private let emojiCount:Int = 0
  private let emojis:EmojiResponseList
  private var levelEmoji: [EmojiResponse] = []
  private var currentPlayWinCount = 0
  private var stage:Int = 0
  private var level:Int = 0
  
  init(emojis: EmojiResponseList) {
    self.emojis = emojis
  }
  
  
  public func startGame() {
    // get last level from data store or defaul to zero
    // get stage within level
    // generate new pair based on level
    generateNewEmojiPairs(level: 0)
    // set emojiCount
  }
  
  public func generateNewEmojiPairs(level: Int) {
    let filtered = emojis.result.filter{ $0.level == level }
    setEmoji(filtered)
  }
  
  public func selectEmojiPair(left: Emoji, right: Emoji) -> CurrentPairingMoveResult {
    if left.id == right.relatedID {
      // count add 1 to total win
      currentPlayWinCount += 1
      return .correct
    } else {
      // reduce 1 from total win
      currentPlayWinCount -= 1
      return .incorrect
    }
  }
  
  public func hasUserWonCurrentPlay() -> CurrentPlayResult {
    
    if currentPlayWinCount == self.levelEmoji.first!.left.count {
      currentPlayWinCount = 0
      return .won
    } else {
      currentPlayWinCount = 0
      return .lost
    }
  }
  
  public func increaseDifficulty() {
    level += 1
  }
  
  public func resetGame() {
    
  }
  
  public func saveGame() {
    
  }
  
  public func fetchCurrentLevelEmojiCount() -> Int {
    self.levelEmoji.first!.left.count
  }
  
  private func setEmoji(_ emojis: [EmojiResponse]) {
    self.levelEmoji = emojis
  }
  
}
