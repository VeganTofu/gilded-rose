
public class GildedRose {
    public var items:[Item]
    
    required public init(items:[Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        let guildedItems = items.compactMap({ return GuildedItem(item: $0)})
        let newItems = guildedItems.compactMap({ return $0.copyItem()})
        self.items = newItems
    }
}
