import Foundation

enum GuildedItemType {
    case backStage,
    sulfuras,
    agedBrie,
    conjured,
    standard;
}

extension GuildedItemType{
    init(_ value: String) {
        switch value.lowercased() {
            case let str where str.contains("aged brie"): self = .agedBrie
            case let str where str.contains("sulfuras"): self = .sulfuras
            case let str where str.contains("backstage"): self = .backStage
            case let str where str.contains("conjured"): self = .conjured
            default: self = .standard
        }
    }
    
    func quality(_ sellIn:Int,_ currentQuantity:Int) -> Int {
        if (self == .backStage && sellIn <= 0) {
            return 0
        }
        return currentQuantity + incrementalQuality(sellIn)
    }
    
    private func incrementalQuality(_ sellIn:Int) -> Int {
        switch self {
            case .backStage:
                return concertQuality(sellIn)
            // aged brie increases in quality
            case .agedBrie:
                return 1
            case .sulfuras:
                return 0
            case .conjured:
                if sellIn < 0 {
                    return -4
                } else {
                    return -2
                }
            default:
                if sellIn < 0 {
                    return -2
                } else {
                    return -1
                }
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