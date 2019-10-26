import Foundation

enum GildedItemType {
    case backStage,
    sulfuras,
    agedBrie,
    conjured,
    standard;
}

extension GildedItemType{
    init(_ value: String) {
        switch value.lowercased() {
            case let str where str.contains("conjured"): self = .conjured
            case let str where str.contains("aged brie"): self = .agedBrie
            case let str where str.contains("sulfuras"): self = .sulfuras
            case let str where str.contains("backstage"): self = .backStage
            default: self = .standard
        }
    }
    
    func quality(_ sellIn:Int,_ currentQuantity:Int, _ maxQuality:Int, _ baseDecrement:Int = -1) -> Int {
        if (self == .backStage && sellIn <= 0) {
            return 0
        }
        if (self == .sulfuras){
            return 80
        }
        let newQuality = currentQuantity + incrementalQuality(sellIn, baseDecrement)
        if newQuality < 0 {
            return 0
            } 
            else {
                return  newQuality >= maxQuality ? maxQuality : newQuality
        }
    }
    
    private func incrementalQuality(_ sellIn:Int, _ baseDecrement:Int = -1) -> Int {
        switch self {
            case .backStage:
                return concertQuality(sellIn)
            case .agedBrie:
                return 1
            case .conjured:
                return sellIn < 0 ? baseDecrement * 4 : baseDecrement * 2
            default:
                return sellIn < 0 ? baseDecrement * 2 : baseDecrement
        }
    }
    
    private func concertQuality(_ sellIn:Int) -> Int {
        switch sellIn {
        // Quality increases by 1 when there are at least 10 days
        case (_) where sellIn > 10:
            return 1
        // Quality increases by 2 when there are 10 days
        case (6...10):
            return 2
        // Quality increases by 3 when there are 5 days or less
        case (0...5):
            return 3
        default:
            return  0
        }
    }

}