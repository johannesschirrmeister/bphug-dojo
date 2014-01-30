module GildedRoseTest where

import GildedRose
import Test

-- Base case
standardItem = Item "testItem" 5 5
sellInReachedItem = Item "testItem" 0 5
fullyDegradedsellInReachedItem = Item "testItem" 0 0

qualityDecreasesByOne = Test (quality (updateQuality standardItem) == 4) "An item that needs to be sold in 2 days, needs to be sold in 1 day tomorrow"
sellInDecreasesByOne = Test (sellIn (updateQuality standardItem) == 4) "An item with quality 2 will have quality 1 tomorrow"
sellInReachedSellInRemainsZero = Test (sellIn (updateQuality sellInReachedItem) == 0) "The sellIn value cannot go below 0"
sellInReachedAndFullyDegraded = Test (sellIn (updateQuality sellInReachedItem) == 0) "The sellIn value cannot go below 0 even if quality is 0"

-- Step 1
sellInReachedQualityDegradesFaster = Test (quality (updateQuality sellInReachedItem) == 3) "The quality of an item that already perished degrades twice as fast"

-- Step 2
fullyDegradedItem = Item "testItem" 2 0
fullyDegraded = Test (quality (updateQuality fullyDegradedItem) == 0) "The quality of an item does not go below 0"

gildedRoseTest = [qualityDecreasesByOne,
				  sellInDecreasesByOne,
				  sellInReachedSellInRemainsZero,
				  sellInReachedAndFullyDegraded,
				  sellInReachedQualityDegradesFaster,
				  fullyDegraded]
