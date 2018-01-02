//
//  Enums.swift
//  Kana
//
//  Created by Luke Morgenstern on 02.01.18.
//  Copyright © 2018 Lukas A. Mueller. All rights reserved.
//

import Foundation

enum Result {
  case correct
  case wrong
}

enum GameStatus {
  case on
  case off
}

enum GameMode {
  case alwaysKanaOption // Roman at top, kana to choose from
  case alwaysRomanOption // other way around
  case mixed // mixed up
}
