@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {

	func setUp(with name: String, sellIn: Int, quality: Int) -> Item {
		let items = [Item(name: name, sellIn: sellIn, quality: quality)]
		let app = GildedRose(items: items);
		app.updateQuality();
		
		return app.items[0]
	}
	
    func testSulfuras() {
		let item = setUp(with: "Sulfuras, Hand of Ragnaros", sellIn: 0, quality: 80)
		XCTAssertEqual(0, item.sellIn)
		XCTAssertEqual(80, item.quality)
	}
	
	func testConjuredItem1() {
		let item = setUp(with: "Conjured Mana Cake", sellIn: 3, quality: 6)
		XCTAssertEqual(2, item.sellIn)
		XCTAssertEqual(4, item.quality)
	}
	
	func testConjuredItem2() {
		let item = setUp(with: "Conjured Mana Cake", sellIn: 3, quality: 1)
		XCTAssertEqual(2, item.sellIn)
		XCTAssertEqual(0, item.quality)
	}
	
	func testConjuredItem3() {
		let item = setUp(with: "Conjured Mana Cake", sellIn: 0, quality: 6)
		XCTAssertEqual(-1, item.sellIn)
		XCTAssertEqual(2, item.quality)
	}
	
	func testConjuredItem4() {
		let item = setUp(with: "Conjured Mana Cake", sellIn: -3, quality: 1)
		XCTAssertEqual(-4, item.sellIn)
		XCTAssertEqual(0, item.quality)
	}
	
	func testConjuredItem5() {
		let item = setUp(with: "Conjured Mana Cake", sellIn: -3, quality: 0)
		XCTAssertEqual(-4, item.sellIn)
		XCTAssertEqual(0, item.quality)
	}
	
	func testConjuredItem6() {
		let item = setUp(with: "Conjured Mana Cake", sellIn: 3, quality: 0)
		XCTAssertEqual(2, item.sellIn)
		XCTAssertEqual(0, item.quality)
	}

    static var allTests : [(String, (GildedRoseTests) -> () throws -> Void)] {
        return [
            ("testSulfuras", testSulfuras),
			("testConjuredItem1", testConjuredItem1),
			("testConjuredItem2", testConjuredItem2),
			("testConjuredItem3", testConjuredItem3),
			("testConjuredItem4", testConjuredItem4),
			("testConjuredItem3", testConjuredItem5),
			("testConjuredItem3", testConjuredItem6)
        ]
    }
}
