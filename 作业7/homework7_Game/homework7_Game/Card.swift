//
//  Card.swift
//  homework7_Game
//
//  Created by student on 2018/12/15.
//  Copyright © 2018年 wq. All rights reserved.
//

import Foundation
struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier()-> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
