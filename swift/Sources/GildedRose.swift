
public class GildedRose {
    var items:[Item]
    private let maxQuality = 50
    
    required public init(items:[Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        for item in items {
            let type = GuildedItemType(item.name)
            let newSellIn = item.sellIn - 1
            let newQuality = type.quality(newSellIn, item.quality)
            item.sellIn = newSellIn
            item.quality = newQuality >= 50 ? maxQuality : newQuality
        }
    }
}
