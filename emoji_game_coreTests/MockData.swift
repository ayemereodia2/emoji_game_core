//
//  MockData.swift
//  emoji_game_coreTests
//
//  Created by ANDELA on 02/02/2025.
//

import Foundation
@testable import emoji_game_core

let mockEmojiResponseList = EmojiResponseList(result: [
    EmojiResponse(
        level: 0,
        stage: [
          Stage(
            left: [
              Emoji(id: "1", name: "corn", icon: "🌽", relatedID: "4"),
              Emoji(id: "2", name: "pig", icon: "🐷", relatedID: "5"),
              Emoji(id: "3", name: "microphone", icon: "🎤", relatedID: "6")
            ],
            right: [
              Emoji(id: "4", name: "baby food", icon: "🥣", relatedID: "1"),
              Emoji(id: "5", name: "bacon", icon: "🥓", relatedID: "2"),
              Emoji(id: "6", name: "singer", icon: "🎶", relatedID: "3")
            ]
          ),
          Stage(
            left: [
              Emoji(id: "7", name: "apple", icon: "🍎", relatedID: "10"),
              Emoji(id: "8", name: "dog", icon: "🐶", relatedID: "11"),
              Emoji(id: "9", name: "paintbrush", icon: "🎨", relatedID: "12")
            ],
            right: [
              Emoji(id: "10", name: "green apple", icon: "🍏", relatedID: "7"),
              Emoji(id: "11", name: "dog face", icon: "🐕", relatedID: "8"),
              Emoji(id: "12", name: "paintbrush", icon: "🖌️", relatedID: "9")
            ]
          )
        ]
    ),
    EmojiResponse(
        level: 1,
        stage: [
          Stage(
            left: [
              Emoji(id: "7", name: "apple", icon: "🍎", relatedID: "10"),
              Emoji(id: "8", name: "dog", icon: "🐶", relatedID: "11"),
              Emoji(id: "9", name: "paintbrush", icon: "🎨", relatedID: "12")
            ],
            right: [
              Emoji(id: "10", name: "green apple", icon: "🍏", relatedID: "7"),
              Emoji(id: "11", name: "dog face", icon: "🐕", relatedID: "8"),
              Emoji(id: "12", name: "paintbrush", icon: "🖌️", relatedID: "9")
            ]
          )]
    )
])

// You can now use mockEmojiResponseList in your tests or for UI preview purposes

let singleResponse = EmojiResponse(
  level: 0,
  stage: [
    Stage(
      left: [
        Emoji(id: "1", name: "corn", icon: "🌽", relatedID: "4"),
        Emoji(id: "3", name: "microphone", icon: "🎤", relatedID: "6"),
        Emoji(id: "2", name: "pig", icon: "🐷", relatedID: "5"),
      ],
      right: [
        Emoji(id: "4", name: "baby food", icon: "🥣", relatedID: "1"),
        Emoji(id: "6", name: "singer", icon: "🎶", relatedID: "3"),
        Emoji(id: "5", name: "bacon", icon: "🥓", relatedID: "2"),
      ]
    )
  ]
)
