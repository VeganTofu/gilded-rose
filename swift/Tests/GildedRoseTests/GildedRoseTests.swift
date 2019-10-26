import Foundation
import XCTest

@testable import GildedRose

class GildedRoseTests: XCTestCase {

    func testBrieIncrements(){
        // Given I have some delicious aged brie
        let items = [Item(name: "aged BRIE", sellIn: 5, quality: 1), 
                    Item(name: "aged BRIE", sellIn: 5, quality: 50)]
        let app = GildedRose(items: items);
        // WHEN day passes
        app.updateQuality();
        // THEN
        XCTAssertEqual(items[0].quality, 2, "quality should increment for brie")
        XCTAssertEqual(items[1].quality, 50, "no item can have quality over 50")
    }

    func testStandardItemIncrements(){
        // Given I have some standard products
        let items = [Item(name: "Ancient but still usable macbook pro", sellIn: 5, quality: 10),
                    Item(name: "Exploding Samsung galaxy", sellIn: 0, quality: 10),
                    Item(name: "php for dummies", sellIn: 5, quality: 0)]
        let app = GildedRose(items: items);
        // WHEN day passes
        app.updateQuality();
        // THEN
        XCTAssertEqual(items[0].quality, 9, "quality should decrese normally")
        XCTAssertEqual(items[1].quality, 8, "quality should decrese by double")
        XCTAssertEqual(items[2].quality, 0, "quality cant go below 0")
    }

    func testConcertIncrements() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 11, quality: 0),
                    Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 6, quality: 0),
                    Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 20, quality: 0),
                    Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 100)]
        let app = GildedRose(items: items);
        // WHEN day passes
        app.updateQuality();
        // THEN
        XCTAssertEqual(items[0].quality, 2, "Quality increases by 2 when there are 10 days or less")
        XCTAssertEqual(items[1].quality, 3, "Quality increases by 3 when there are 5 days or less")
        XCTAssertEqual(items[2].quality, 1, "Quality increases by 1 when there are more then 10 days")
        XCTAssertEqual(items[3].quality, 0, "quality revert to 0 when concert is over")
    }

    func testConjuredIncrements() {
        let items = [Item(name: "Conjured bucket", sellIn: 2, quality: 10),
                    Item(name: "Conjured staff", sellIn: 0, quality: 10),
                    Item(name: "Conjured staff", sellIn: 0, quality: 1)]
        let app = GildedRose(items: items);
        // WHEN day passes
        app.updateQuality();
        // THEN
        XCTAssertEqual(items[0].quality, 8, "quality should decrease double nomal deteriorate")
        XCTAssertEqual(items[1].quality, 6, "quality should decrease by double double nomal deteriorate")        
        XCTAssertEqual(items[2].quality, 0, "quality should 0")
    }

    func testSulfurasIncrements(){
        let items = [Item(name: "Sulfuras bucket", sellIn: 2, quality: 70)]
        let app = GildedRose(items: items);
        // WHEN day passes
        app.updateQuality();
        // THEN
        XCTAssertEqual(items[0].quality, 80, "quality should always be 80")
    }
}

#if os(Linux)
extension GildedRoseTests {
    static var allTests : [(String, (GildedRoseTests) -> () throws -> Void)] {
        return [
            ("testFoo", testFoo),
        ]
    }    
}
#endif