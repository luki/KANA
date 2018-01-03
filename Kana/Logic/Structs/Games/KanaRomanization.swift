//
//  KanaRomanization.swift
//  Kana
//
//  Created by Luke Morgenstern on 02.01.18.
//  Copyright © 2018 Lukas A. Mueller. All rights reserved.
//

import Foundation

struct KanaRomanizationGame {
  
  var toCome: [String:String] {
    willSet {
      if toCome.count == 1 { status = .off }
    }
  }
  var answered: [String:String]
  var missed: [String:String]
  var status: GameStatus
  var mode: GameMode
  
  init (startGameWith dict: [String:String], andGameMode gm: GameMode) {
    status = .on
    self.toCome = dict
    self.answered = [:]
    self.missed = [:]
    self.mode = gm
  }
  
  var getAmountLeft: Int {
    return toCome.count
  }
  
  mutating func answer(with a: String) -> Result {
    var result: Result = .wrong
    
    if a == toCome.first!.key || a == toCome.first!.value {
      answered[toCome.first!.key] = toCome.first!.value
      result = .correct
    }
    else { missed[toCome.first!.key] = toCome.first!.value }
    
    toCome.removeValue(forKey: toCome.first!.key)
    
    return result
  }
  
  var getCharacterRound: (String, (String, String, String, String)) {
    let keyOrValueForChoosing = getIndexByGameMode
    
    var chooseFrom = toCome
    chooseFrom += answered
    chooseFrom += missed
    
    // - 1 because we're going to add +1 later, since the first element shouldn't be able to be chosen
    
    var options = [String]()
    
    // Generate 3 random elements for options
    _ = Array(0..<3).forEach { _ in
      let indexOfRandomOptEle = Int(arc4random_uniform(UInt32(chooseFrom.count-1)))
      
      if keyOrValueForChoosing == 0 { options.insert(Array(chooseFrom.keys)[indexOfRandomOptEle+1], at: 0) }
      if keyOrValueForChoosing == 1 { options.insert(Array(chooseFrom.values)[indexOfRandomOptEle+1], at: 0) }
    }
    
    let indexToInsertAnswerAt = Int(arc4random_uniform(4))
    var atTop = String()
    
    if keyOrValueForChoosing == 0 {
      options.insert(toCome.first!.key, at: indexToInsertAnswerAt)
      atTop = toCome.first!.value
    } else if keyOrValueForChoosing == 1 {
      options.insert(toCome.first!.value, at: indexToInsertAnswerAt)
      atTop = toCome.first!.key
    }
    
    return (atTop, (options[0], options[1], options[2], options[3]))
  }
  
  private var getIndexByGameMode: Int {
    switch self.mode {
    case .alwaysKanaOption:
      return 0
    case .alwaysRomanOption:
      return 1
    case .mixed:
      return Int(arc4random_uniform(2))
    }
  }
  
  
}
