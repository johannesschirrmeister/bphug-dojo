module GildedRoseTest where

import GildedRose
import Test

-- Base case
standardItem = Item "testItem" 5 5
sellInReachedItem = Item "testItem" 0 5
fullyDegradedsellInReachedItem = Item "testItem" 0 0

qualityDecreasesByOne = Test (quality (updateItem standardItem) == 4) "An item that needs to be sold in 2 days, needs to be sold in 1 day tomorrow"
sellInDecreasesByOne = Test (sellIn (updateItem standardItem) == 4) "An item with quality 2 will have quality 1 tomorrow"
sellInReachedSellInRemainsZero = Test (sellIn (updateItem sellInReachedItem) == 0) "The sellIn value cannot go below 0"
sellInReachedAndFullyDegraded = Test (sellIn (updateItem sellInReachedItem) == 0) "The sellIn value cannot go below 0 even if quality is 0"

-- Step 1 "Once the sell by date has passed, Quality degrades twice as fast"
sellInReachedQualityDegradesFaster = Test (quality (updateItem sellInReachedItem) == 3) "The quality of an item that already perished degrades twice as fast"

-- Step 2 "The Quality of an item is never negative"
fullyDegradedItem = Item "testItem" 2 0
fullyDegraded = Test (quality (updateItem fullyDegradedItem) == 0) "The quality of an item does not go below 0"

-- Step 3 "'Aged Brie' actually increases in Quality the older it gets"
agedBrie = Item "AgedBrie" 3 3
agedBrieReachedSellIn = Item "AgedBrie" 0 3
agedBrieQualityIncreases = Test (quality (updateItem agedBrie) == 4) "The quality of AgedBrie increases"
agedBrieReachedSellInQualityIncreases = Test (quality (updateItem agedBrieReachedSellIn) == 4) "The quality of AgedBrie increases even if it has reached its sellIn date"

-- Step 4 "The Quality of an item is never more than 50"
veryAgedBrie = Item "AgedBrie" 1 50
veryAgedBrieDoesNotIncreaseQuality = Test (quality (updateItem veryAgedBrie) == 50) "The quality of AgedBrie does not exceed 50"


gildedRoseTest = [qualityDecreasesByOne,
				  sellInDecreasesByOne,
				  sellInReachedSellInRemainsZero,
				  sellInReachedAndFullyDegraded,
				  sellInReachedQualityDegradesFaster,
				  fullyDegraded,
				  agedBrieQualityIncreases,
                  agedBrieReachedSellInQualityIncreases,
                  veryAgedBrieDoesNotIncreaseQuality]

