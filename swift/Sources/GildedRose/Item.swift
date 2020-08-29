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
	
	func updateItem()

}

extension Item : UpdateItemProtocol {
	
	func updateItem() {
		sellIn = sellIn - 1
		
		let deltaQuality = sellIn < 0 ? -2 : -1
		quality = max(min(quality + deltaQuality, 50), 0)
	}
	
}

public class Sulfuras : Item {
	
	override func updateItem() {
		quality = 80
	}
	
}

public class ConjuredItem : Item {
	
	override func updateItem() {
		sellIn = sellIn - 1
		
		let deltaQuality = sellIn < 0 ? -4 : -2
		quality = max(min(quality + deltaQuality, 50), 0)
	}
	
}

public class AgedBrie : Item {
	
	override func updateItem() {
		sellIn = sellIn - 1
		
		let deltaQuality = sellIn < 0 ? 2 : 1
		quality = max(min(quality + deltaQuality, 50), 0)
	}
	
}

public class BackstagePass : Item {
	
	override func updateItem() {
		sellIn = sellIn - 1
		
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
