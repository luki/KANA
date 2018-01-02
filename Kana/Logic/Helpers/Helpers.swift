//
//  helpers.swift
//  Kana
//
//  Created by Luke Morgenstern on 02.01.18.
//  Copyright © 2018 Lukas A. Mueller. All rights reserved.
//

import Foundation

func += <K, V> (left: inout [K:V], right: [K:V]) {
  for (k, v) in right {
    left[k] = v
  }
}
