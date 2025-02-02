//
//  Emoji.swift
//  emoji_game_core
//
//  Created by ANDELA on 02/02/2025.
//

import Foundation

public struct Emoji: Identifiable, Equatable {
  public let id:String
  let name: String
  let icon: String
  let relatedID: String
  
  public static func == (lhs:Emoji, rhs:Emoji) -> Bool {
    lhs.name == rhs.name
  }
}


public struct EmojiResponse{
  let level: Int
  let stage: [Stage]
}

public struct EmojiResponseList {
  let result: [EmojiResponse]
}

public struct Stage {
  let left: [Emoji]
  let right: [Emoji]
}

