import Foundation

public class GildedRose {
    var items:[Item]
    
    public init(items:[Item]) {
        self.items = items
    }
	
	public func updateQuality() {
		items.forEach { item in
			// "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
			if item.name == "Sulfuras, Hand of Ragnaros" {
				return
			}
			
			// At the end of each day our system lowers sellIn value
			item.sellIn = item.sellIn - 1
			
			let name = item.name
			let sellIn = item.sellIn
			let quality = item.quality
			
			// Once the sell by date has passed, Quality degrades twice as fast
			let qualityModifier = (sellIn < 0 ? 2 : 1) * Item.normalQualityModifyingFactor()
			
			var deltaQuality = 0
			
			switch name {
			case _ where name.contains("Conjured"):
				// "Conjured" items degrade in Quality twice as fast as normal items
				deltaQuality = -qualityModifier * 2
			case _ where name.contains("Backstage passes"):
				switch sellIn {
				case _ where sellIn >= 10:
					// "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches
					deltaQuality = Item.normalQualityModifyingFactor()
				case 5..<10:
					// Quality increases by 2 when there are 10 days or less
					deltaQuality = Item.normalQualityModifyingFactor() * 2
				case 0..<5:
					// by 3 when there are 5 days or less
					deltaQuality = Item.normalQualityModifyingFactor() * 3
				default:
					// Quality drops to 0 after the concert
					deltaQuality = -quality
				}
			case "Aged Brie":
				// "Aged Brie" actually increases in Quality the older it gets
				deltaQuality = Item.normalQualityModifyingFactor() * qualityModifier
			default:
				deltaQuality = -qualityModifier
			}
			
			// The Quality of an item is never negative
			// The Quality of an item is never more than 50
			item.quality = max(min(quality + deltaQuality, 50), 0)
		}
	}

}

public extension Item {
	
	// In case a normal item will start modifying faster than with 1 quality per day when sellIn is positive, this value will need to be updated corespondingly
	static func normalQualityModifyingFactor() -> Int {
		return 1
	}
	
}
