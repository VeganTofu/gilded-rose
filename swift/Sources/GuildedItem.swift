import Foundation

enum GuildedItemType {
    case backStage,
    sulfuras,
    agedBrie,
    conjured,
    none;
}

extension GuildedItemType{
    init(_ value: String) {
        switch value.lowercased() {
            case let str where str.contains("aged brie"): self = .agedBrie
            case let str where str.contains("sulfuras"): self = .sulfuras
            case let str where str.contains("backstage"): self = .backStage
            case let str where str.contains("conjured"): self = .conjured
            default: self = .none
        }
    }
    
    func quantity(_ sellIn:Int,_ currentQuantity:Int) -> Int {
        if (self == .backStage && sellIn <= 0) {
            return 0
        }
        return currentQuantity + incrementalQuantity(sellIn)
    }
    
    private func incrementalQuantity(_ sellIn:Int) -> Int {
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

struct GuildedItem {
    let item:Item
    private let type:GuildedItemType
    private let maxQuality = 50

    func copyItem() -> Item {
        let newSellIn = item.sellIn - 1
        let newQuantity = type.quantity(newSellIn, item.quality)
        return Item(name: item.name,
                    sellIn: newSellIn,
                    quality: newQuantity >= maxQuality ? maxQuality : newQuantity)
    }
}

extension GuildedItem {
    init(item:Item){
        self.item = item
        self.type = GuildedItemType(item.name)
    }
}
