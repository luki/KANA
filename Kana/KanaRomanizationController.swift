//
//  ViewController.swift
//  Kana
//
//  Created by Luke Morgenstern on 01.01.18.
//  Copyright © 2018 Lukas A. Mueller. All rights reserved.
//

import UIKit

extension UIStackView {
  func addBackground(withColor c: UIColor) {
    let view = UIView(frame: bounds)
    view.backgroundColor = c
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    insertSubview(view, at: 0)
  }
}

class SelectionField: UIButton {
  
  let label: UILabel = {
    let l = UILabel()
    l.translatesAutoresizingMaskIntoConstraints = false
    l.textColor = .black
    l.font = UIFont.systemFont(ofSize: 109/2, weight: .medium)
    l.text = "no"
    l.textAlignment = .center
    return l
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    addSubview(label)
    layer.cornerRadius = 24
    
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44/2),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -44/2),
      label.centerYAnchor.constraint(equalTo: centerYAnchor)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class KanaRomanizationController: UIViewController {
  
  let answersLeft: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 37/2, weight: .bold)
    label.textColor = UIColor(red: 173/255, green: 173/255, blue: 173/255, alpha: 1.0)
    label.text = "10 left"
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let correctLabel: UILabel = {
    let cl = UILabel(frame: CGRect(x: 0, y: 0, width: 64/2, height: 64/2))
    cl.translatesAutoresizingMaskIntoConstraints = false
    cl.backgroundColor = UIColor(red: 130/255, green: 206/255, blue: 195/255, alpha: 1.0)
    cl.textAlignment = .center
    cl.font = UIFont.systemFont(ofSize: 43/2, weight: .bold)
    cl.textColor = .white
    cl.text = "5"
    cl.layer.cornerRadius = 64/4
    cl.layer.masksToBounds = true
    return cl
  }()
  
  let wrongLabel: UILabel = {
    let cl = UILabel(frame: CGRect(x: 0, y: 0, width: 64/2, height: 64/2))
    cl.text = "5"
    cl.translatesAutoresizingMaskIntoConstraints = false
    cl.backgroundColor = UIColor(red: 243/255, green: 126/255, blue: 135/255, alpha: 1.0)
    cl.textAlignment = .center
    cl.font = UIFont.systemFont(ofSize: 43/2, weight: .bold)
    cl.textColor = .white
    cl.layer.cornerRadius = 64/2/2
    cl.layer.masksToBounds = true
    return cl
  }()
  
  let practiceTitle: UILabel = {
    let pt = UILabel()
    pt.translatesAutoresizingMaskIntoConstraints = false
    pt.attributedText = NSAttributedString(string: "Katakana Practice", attributes: [
      NSAttributedStringKey.foregroundColor: UIColor.white,
      NSAttributedStringKey.font: UIFont.systemFont(ofSize: 41/2, weight: UIFont.Weight.bold)
      ])
    
    return pt
  }()
  
  let topLabel: UILabel = {
    let tl = UILabel()
    tl.translatesAutoresizingMaskIntoConstraints = false
    tl.font = UIFont.systemFont(ofSize: 275/2, weight: .medium)
    tl.textColor = .black
    tl.text = "ネ"
    tl.textAlignment = .center
    return tl
  }()
  
  let topBackground: UIView = {
    let v = UIView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.backgroundColor = .white
    v.layer.cornerRadius = 24
    if #available(iOS 11.0, *) {
      v.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    } else {
      // Fallback on earlier versions
    }
    return v
  }()
  
  let selectionStack: UIStackView = {
    let sv = UIStackView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.backgroundColor = .lightGray
    sv.distribution = .fillEqually
    sv.spacing = 44/2
    sv.axis = .vertical
    sv.layoutMargins = UIEdgeInsets(top: 44/2, left: 44/2, bottom: 44/2, right: 44/2)
    sv.isLayoutMarginsRelativeArrangement = true
    return sv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    
    view.addSubview(selectionStack)
    view.addSubview(topBackground)
    view.addSubview(practiceTitle)
    topBackground.addSubview(topLabel)
    topBackground.addSubview(correctLabel)
    topBackground.addSubview(wrongLabel)
    topBackground.addSubview(answersLeft)
    
    let topStack = UIStackView()
    topStack.spacing = 44/2
    topStack.distribution = .fillEqually
    
    for _ in 0...1 {
      let sf = SelectionField()
      sf.backgroundColor = .white
      topStack.addArrangedSubview(sf)
    }
    
    let bottomStack = UIStackView()
    bottomStack.spacing = 44/2
    bottomStack.distribution = .fillEqually
    bottomStack.axis = .horizontal
    
    for _ in 0...1 {
      let sf = SelectionField()
      sf.backgroundColor = .white
      bottomStack.addArrangedSubview(sf)
    }
    
    selectionStack.addArrangedSubview(topStack)
    selectionStack.addArrangedSubview(bottomStack)
    selectionStack.addBackground(withColor: .lightGray)
    
    NSLayoutConstraint.activate([
      selectionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      selectionStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      selectionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      selectionStack.heightAnchor.constraint(equalToConstant: 749/2),
      
      topBackground.bottomAnchor.constraint(equalTo: selectionStack.topAnchor),
      topBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 116/2),
      topBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      
      practiceTitle.bottomAnchor.constraint(equalTo: topBackground.topAnchor, constant: -5),
      practiceTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44/2),
      practiceTitle.heightAnchor.constraint(equalToConstant: 41/2),
      practiceTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44/2),
      
      topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      topLabel.centerYAnchor.constraint(equalTo: topBackground.centerYAnchor, constant: 51/2),
      
      correctLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44/2),
      correctLabel.topAnchor.constraint(equalTo: topBackground.topAnchor, constant: 36/2),
      
      wrongLabel.leadingAnchor.constraint(equalTo: correctLabel.trailingAnchor, constant: 16/2),
      wrongLabel.topAnchor.constraint(equalTo: topBackground.topAnchor, constant: 36/2),
      
      answersLeft.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44/2),
      answersLeft.topAnchor.constraint(equalTo: topBackground.topAnchor, constant: 36/2),
      answersLeft.widthAnchor.constraint(equalToConstant: 140/2)
      ])
  }
}

