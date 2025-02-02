//
//  Game.swift
//  emoji_game_core
//
//  Created by ANDELA on 02/02/2025.
//

import Foundation

// each game level
// contains 5 stages of emoji game play
// 7 levels
// 5 stages
// = 35 game plays.

public class Game: EmojiGameInterface,GameEventEmitter {
  
  var onStageCompletion: ((CurrentPlayResult) -> Void)?
  var onNewLevel: ((Int) -> Void)?
  var onGameCompletion: (() -> Void)?
  
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
    guard level < levelEmoji.count, let currentStage = levelEmoji[safe: level]?.stage[safe: stage] else {
      // log invalid stage or level
      return .lost
    }
    
    if currentPlayWinCount == currentStage.left.count {
      currentPlayWinCount = 0
      nextStage()
      onStageCompletion?(.won)
      return .won
    } else {
      currentPlayWinCount = 0
      onStageCompletion?(.lost)
      return .lost
    }
  }
  
  public func increaseDifficulty() {
    level += 1
  }
  
  public func nextStage() {
    let stageCount = self.levelEmoji[safe: level]?.stage.count ?? 0
    let maxLevel = self.levelEmoji.map { $0.level }.max() ?? -1 // Assumes levels start from 0
    
    if stage < stageCount {
      stage += 1
    } else if level < maxLevel{
      level += 1 // new level
      stage = 0 // first stage
      generateNewEmojiPairs(level: level) // Prepare for the new level
      onNewLevel?(level + 1)
    } else {
      // All levels and stages are completed
      stage = 0
      level = 0 // Reset to start if you want to loop the game
      // Game is completed
      onGameCompletion?()
    }
    
  }
  
  public func resetGame() {
    
  }
  
  public func saveGame() {
    // save game level and stage to external store
  }
  
  public func fetchCurrentLevelEmojiCount() -> Int {
    self.levelEmoji[level].stage[stage].left.count
  }
  
  private func setEmoji(_ emojis: [EmojiResponse]) {
    self.levelEmoji = emojis
  }
  
}


// delegate communication approach to UI
protocol GameEventEmitter: AnyObject {
    var onStageCompletion: ((CurrentPlayResult) -> Void)? { get set }
    var onNewLevel: ((Int) -> Void)? { get set }
    var onGameCompletion: (() -> Void)? { get set }
}


/*
 sample UI consumption
 import Combine

 class GameViewModel {
     private let game: Game
     var stageCompletion = PassthroughSubject<CurrentPlayResult, Never>()
     var newLevel = PassthroughSubject<Int, Never>()
     var gameCompletion = PassthroughSubject<Void, Never>()

     private var cancellables = Set<AnyCancellable>()

     init(game: Game) {
         self.game = game

         // Bind the events
         game.onStageCompletion = { [weak self] result in
             self?.stageCompletion.send(result)
         }

         game.onNewLevel = { [weak self] level in
             self?.newLevel.send(level)
         }

         game.onGameCompletion = { [weak self] in
             self?.gameCompletion.send()
         }
     }
 }

 */
