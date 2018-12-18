//
//  Concentration.swift
//  homework7_Game
//
//  Created by student on 2018/12/15.
//  Copyright © 2018年 wq. All rights reserved.
//

import Foundation
class Concentration
{
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    func chooseCard(at index: Int){
        if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
            //只有一张牌翻起的情况
            if cards[matchIndex].identifier == cards[index].identifier {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFaceUp = true
            indexOfOneAndOnlyFaceUpCard = nil
        }else {
            //没有卡片或者有两张卡片翻起的情况
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = false
            }
            cards[index].isFaceUp = true
            indexOfOneAndOnlyFaceUpCard = index
        }
       
    }
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards
        {
            let card = Card()
            cards += [card, card]
        }
    }
}
