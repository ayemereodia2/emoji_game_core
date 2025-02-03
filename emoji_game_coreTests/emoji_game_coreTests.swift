//
//  emoji_game_coreTests.swift
//  emoji_game_coreTests
//
//  Created by ANDELA on 02/02/2025.
//

import Testing
import XCTest

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
  
  @Test func gamePlaySession() async  {
    // Arrange
    let game = Game(emojis: mockEmojiResponseList)
    game.startGame()
    
    game.onStageCompletion = { status in
      #expect(status == .won)
    }

    
    let left1 = mockEmojiResponseList.result[0].stage[0].left[0]
    let right1 = mockEmojiResponseList.result[0].stage[0].right[0]
    
    let left2 = mockEmojiResponseList.result[0].stage[0].left[1]
    let right2 = mockEmojiResponseList.result[0].stage[0].right[1]
    
    let left3 = mockEmojiResponseList.result[0].stage[0].left[2]
    let right3 = mockEmojiResponseList.result[0].stage[0].right[2]
    // Assert
    let result1 = game.selectEmojiPair(left: left1, right: right1)
    let result2 = game.selectEmojiPair(left: left2, right: right2)
    let result3 = game.selectEmojiPair(left: left3, right: right3)
    
    #expect(result1 == .correct)
    #expect(result2 == .correct)
    #expect(result3 == .correct)
    
  
    let currentPlay1 = game.hasUserWonCurrentPlay()
    
    #expect(currentPlay1 == .won)

    
    let left11 = mockEmojiResponseList.result[0].stage[1].left[0]
    let right11 = mockEmojiResponseList.result[0].stage[1].right[0]
    
    let left22 = mockEmojiResponseList.result[0].stage[1].left[1]
    let right22 = mockEmojiResponseList.result[0].stage[1].right[1]
    
    let left33 = mockEmojiResponseList.result[0].stage[1].left[2]
    let right33 = mockEmojiResponseList.result[0].stage[1].right[2]
    // Assert
    let result11 = game.selectEmojiPair(left: left11, right: right11)
    let result22 = game.selectEmojiPair(left: left22, right: right22)
    let result33 = game.selectEmojiPair(left: left33, right: right33)
    
    #expect(result11 == .correct)
    #expect(result22 == .correct)
    #expect(result33 == .correct)
    
    let currentPlay2 = game.hasUserWonCurrentPlay()

    #expect(game.getLevel() == 0)
    #expect(game.getStage() == 2)
    #expect(currentPlay2 == .won)
    
    
    let left13 = mockEmojiResponseList.result[0].stage[2].left[0]
    let right13 = mockEmojiResponseList.result[0].stage[2].right[2]
    
    let left23 = mockEmojiResponseList.result[0].stage[2].left[1]
    let right23 = mockEmojiResponseList.result[0].stage[2].right[0]
    
    let left34 = mockEmojiResponseList.result[0].stage[2].left[2]
    let right35 = mockEmojiResponseList.result[0].stage[2].right[1]
    // Assert
    let result13 = game.selectEmojiPair(left: left13, right: right13)
    let result23 = game.selectEmojiPair(left: left23, right: right23)
    let result34 = game.selectEmojiPair(left: left34, right: right35)
    
    #expect(result13 == .correct)
    #expect(result23 == .correct)
    #expect(result34 == .correct)
    
    let currentPlay25 = game.hasUserWonCurrentPlay()

    #expect(game.getLevel() == 1)
    #expect(game.getStage() == 0)
    #expect(currentPlay25 == .won)
    
    let nextLevelEmoji = game.getCurrentEmoji()
    #expect(nextLevelEmoji.first!.level == 1)
    
    await withCheckedContinuation { continuation in
      continuation.resume()
    }
  }

}

// each level
// contains 5 stages of emoji game play
// 7 levels
// 5 stages
// = 35 game plays.

final class EmojiCoreTest: XCTestCase {
  func testGamePlaySession() async {
    let expectation = XCTestExpectation(description: "Check next level value")
    // Arrange
    let game = Game(emojis: mockEmojiResponseList)
    game.startGame()
    
    // set completion handler before fulfilment is made
    game.onStageCompletion = { status in
        expectation.fulfill()
      XCTAssertEqual(status, .won)
      XCTAssertEqual(game.getStage(), 1)
    }
    
    
    let left1 = mockEmojiResponseList.result[0].stage[0].left[0]
    let right1 = mockEmojiResponseList.result[0].stage[0].right[0]
    
    let left2 = mockEmojiResponseList.result[0].stage[0].left[1]
    let right2 = mockEmojiResponseList.result[0].stage[0].right[1]
    
    let left3 = mockEmojiResponseList.result[0].stage[0].left[2]
    let right3 = mockEmojiResponseList.result[0].stage[0].right[2]
    // Assert
    let result1 = game.selectEmojiPair(left: left1, right: right1)
    let result2 = game.selectEmojiPair(left: left2, right: right2)
    let result3 = game.selectEmojiPair(left: left3, right: right3)
    
    // Assert
    let currentPlay = game.hasUserWonCurrentPlay()
    XCTAssertEqual(currentPlay, .won)
    XCTAssertEqual(result1, .correct)
    XCTAssertEqual(result2, .correct)
    XCTAssertEqual(result3, .correct)

    // Wait for the expectation to be fulfilled
    await fulfillment(of: [expectation], timeout: 10)
  }
}
