//
//  Array+Ext.swift
//  emoji_game_core
//
//  Created by ANDELA on 02/02/2025.
//

import Foundation
extension Collection {
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
