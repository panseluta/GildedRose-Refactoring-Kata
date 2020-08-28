import Foundation

public class Item {
    public var name: String
    public var sellIn: Int
    public var quality: Int
    
    public init(name: String, sellIn: Int, quality: Int) {
        self.name = name
        self.sellIn = sellIn
        self.quality = quality
    }
}

extension Item: CustomStringConvertible {
    public var description: String {
        return self.name + ", " + String(self.sellIn) + ", " + String(self.quality);
    }
}

@objc protocol UpdateItemProtocol {
	
	func updateQuality()
	func updateSellIn()

}

extension Item : UpdateItemProtocol {
	
	func updateQuality() {
		let deltaQuality = sellIn < 0 ? -2 : -1
		quality = max(min(quality + deltaQuality, 50), 0)
	}
	
	func updateSellIn() {
		sellIn = sellIn - 1
	}
	
}

public class Sulfuras : Item {
	
	override func updateQuality() {
		quality = 80
	}
	
	override func updateSellIn() {
		return
	}
	
}

public class ConjuredItem : Item {
	
	override func updateQuality() {
		let deltaQuality = sellIn < 0 ? -4 : -2
		quality = max(min(quality + deltaQuality, 50), 0)
	}
	
}

public class AgedBrie : Item {
	
	override func updateQuality() {
		let deltaQuality = sellIn < 0 ? 2 : 1
		quality = max(min(quality + deltaQuality, 50), 0)
	}
	
}

public class BackstagePass : Item {
	
	override func updateQuality() {
		var deltaQuality = 0
		
		switch sellIn {
		case _ where sellIn >= 10:
			deltaQuality = 1
		case 5..<10:
			deltaQuality = 2
		case 0..<5:
			deltaQuality = 3
		default:
			deltaQuality = -quality
		}
		
		quality = max(min(quality + deltaQuality, 50), 0)
	}
	
}
