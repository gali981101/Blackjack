import UIKit

let cards: Array = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
var numberOfCards: Dictionary = ["2": 0, "3": 0, "4": 0, "5": 0, "6": 0, "7": 0, "8": 0, "9": 0, "10": 0, "J": 0, "Q": 0, "K": 0, "A": 0]

var playerCard: String?
var bankerCard: String?

var cardsInPlayerHand: Array = [String]()
var cardsInBankerHand: Array = [String]()

var playerScore: Int = 0
var bankerScore: Int = 0

func randomCard() -> String {
    var loading: Bool = true
    
    while loading {
        let pokerCard = cards.randomElement()!
        
        if numberOfCards[pokerCard] == 2 {
            continue
        } else {
            loading.toggle()
            return pokerCard
        }
    }
}

func convertScore(_ card: String) -> Int {
    if card == "A" {
        let point: Array = [1, 11]
        return point.randomElement()!
    } else if card == cards[9] || card == cards[10] || card == cards[11] {
        return 10
    } else {
        return Int(card)!
    }
}

func drawCards(isPlayer: Bool) {
    if isPlayer {
        playerCard = randomCard()
        cardsInPlayerHand.append(playerCard!)
        playerScore += convertScore(playerCard!)
        numberOfCards[playerCard!]! += 1
    } else {
        bankerCard = randomCard()
        cardsInBankerHand.append(bankerCard!)
        bankerScore += convertScore(bankerCard!)
        numberOfCards[bankerCard!]! += 1
    }
}

func bankerDrawCardUntil17() {
    while bankerScore < 17 {
        print("莊家補牌")
        drawCards(isPlayer: false)
    }
}

func firstRound() {
    drawCards(isPlayer: true)
    drawCards(isPlayer: false)
    
    print("玩家第一張牌為 \(playerCard!)，莊家第一張牌為 \(bankerCard!)")
}

func otherRound() {
    while playerScore < 21 || bankerScore < 21 {
        if playerScore < 11 || Bool.random() {
            print("玩家要補牌嗎？要")
            drawCards(isPlayer: true)
        } else {
            print("玩家要補牌嗎？不要")
            bankerDrawCardUntil17()
            break
        }
        
        if bankerScore < 17 || Bool.random() {
            print("莊家補牌")
            drawCards(isPlayer: false)
        }
        
        if cardsInBankerHand.count == 5 && !(bankerScore > 21) {
            break
        }
    }
}

func winOrLose() {
    if playerScore > 21 {
        print("玩家爆牌，莊家獲勝")
    } else {
        print("莊家爆牌，玩家獲勝")
    }
}

func point21() {
    if playerScore == 21 {
        print("玩家 21 點獲勝")
    } else {
        print("莊家 21 點獲勝")
    }
}

func otherCase() {
    (21 - playerScore) < (21 - bankerScore) ? print("玩家獲勝") : print("莊家獲勝")
    
    if playerScore == bankerScore {
        print("平手")
    }
}

func convertCardToString(of cards: [String]) -> String {
    var remainingCardsInString: String = ""
    var count: Int = 0
    
    remainingCardsInString.append("(")
    
    for card in cards {
        remainingCardsInString.append(card)
        count += 1
        
        if !(count == cards.count) {
            remainingCardsInString.append(" ")
        } else {
            remainingCardsInString.append(")")
        }
    }
    
    return remainingCardsInString
}

func whoWin() {
    if playerScore > 21 || bankerScore > 21 {
        winOrLose()
    } else if playerScore == 21 || bankerScore == 21 {
        point21()
    } else if cardsInBankerHand.count == 5 && !(bankerScore > 21) {
        print("莊家五張牌獲勝")
    } else {
        otherCase()
    }
    
    print("玩家 \(playerScore) 點 \((convertCardToString(of: cardsInPlayerHand))); 莊家 \(bankerScore) 點 \((convertCardToString(of: cardsInBankerHand)))")
}

func playGame() {
    firstRound()
    otherRound()
    whoWin()
}

playGame()




