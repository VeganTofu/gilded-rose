
public class GildedRose {
    var items:[Item]
    private let maxQuality = 50
    
    required public init(items:[Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        for item in items {
            let type = GildedItemType(item.name)
            let newSellIn = item.sellIn - 1
            item.quality = type.quality(newSellIn, item.quality, 50, -1)
            item.sellIn = newSellIn
        }
    }
}
