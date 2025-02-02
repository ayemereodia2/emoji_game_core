//
//  emoji_game_coreTests.swift
//  emoji_game_coreTests
//
//  Created by ANDELA on 02/02/2025.
//

import Testing
@testable import emoji_game_core

struct emoji_game_coreTests {
  class GameSpy: Game {
      var generateNewEmojiPairsCallCount = 0
      var isGenerateNewEmojiPairsCalled = false
      var capturedLevels: [Int] = []
      
      override func generateNewEmojiPairs(level: Int) {
          generateNewEmojiPairsCallCount += 1
          isGenerateNewEmojiPairsCalled = true
          capturedLevels.append(level)
          return super.generateNewEmojiPairs(level: level)
      }
  }
  
    @Test func generateNewEmojiPairs() {
      // Arrange
      let game = Game(emojis: mockEmojiResponseList)
      // Act
      game.generateNewEmojiPairs(level: 0)
      // Expect
      let gameFirtCount = 3
      #expect(game.fetchCurrentLevelEmojiCount() == gameFirtCount)
    }

  @Test func gameStart_Returns_Three_Pair_Emoji()  {
      // Arrange
      let game = GameSpy(emojis: mockEmojiResponseList)
      // Act
      game.startGame()
      
      // Expect
      let gameFirtCount = 3
      #expect(game.isGenerateNewEmojiPairsCalled == true)
      #expect(game.fetchCurrentLevelEmojiCount() == gameFirtCount)
    }
  
  @Test func selectCorrectMatchingEmojiPair()  {
    // Arrange
    let game = Game(emojis: mockEmojiResponseList)
    game.startGame()
    let left = singleResponse.stage[0].left.first!
    let right = singleResponse.stage[0].right.first!
    // Assert
    let result = game.selectEmojiPair(left: left, right: right)
    #expect(result == .correct)
  }
  
  @Test func selectIncorrectEmojiPair()  {
    // Arrange
    let game = Game(emojis: mockEmojiResponseList)
    game.startGame()
    let left = singleResponse.stage[0].left[1]
    let right = singleResponse.stage[0].right[2]
    // Assert
    let result = game.selectEmojiPair(left: left, right: right)
    #expect(result == .incorrect)
  }
  
  @Test func userStillLosingCurrentPlay()  {
    // Arrange
    let game = Game(emojis: mockEmojiResponseList)
    game.startGame()
    let left = singleResponse.stage[0].left.first!
    let right = singleResponse.stage[0].right.first!
    // Assert
    let result = game.selectEmojiPair(left: left, right: right)
    let currentPlay = game.hasUserWonCurrentPlay()
    
    #expect(result == .correct)
    #expect(currentPlay == .lost)
  }
  
  @Test func userWonCurrentPlay()  {
    // Arrange
    let game = Game(emojis: mockEmojiResponseList)
    game.startGame()
    let left = singleResponse.stage[0].left[0]
    let right = singleResponse.stage[0].right[2]
    // Assert
    let result1 = game.selectEmojiPair(left: left, right: right)
    let result2 = game.selectEmojiPair(left: left, right: right)
    let result3 = game.selectEmojiPair(left: left, right: right)
    

    let currentPlay = game.hasUserWonCurrentPlay()
    
    #expect(result1 == .incorrect)
    #expect(result2 == .incorrect)
    #expect(result3 == .incorrect)
    
    #expect(currentPlay == .lost)
  }

}

// each level
// contains 5 stages of emoji game play
// 7 levels
// 5 stages
// = 35 game plays.
