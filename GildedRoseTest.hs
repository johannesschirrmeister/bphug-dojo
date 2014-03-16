{-# LANGUAGE NamedFieldPuns  #-}

module GildedRoseTest where

import GildedRose
import Test

-- Base case
standardItem = StandardItem 5 5
sellInReachedItem = StandardItem 0 5
fullyDegradedItem = StandardItem 0 0

qualityDecreasesByOne = Test (std_sellIn (updateItem standardItem) == 4) "An item that needs to be sold in 5 days, needs to be sold in 4 days tomorrow"
sellInDecreasesByOne = Test (std_quality (updateItem standardItem) == 4) "An item with quality 5 will have quality 4 tomorrow"
sellInReachedSellInRemainsZero = Test (std_sellIn (updateItem sellInReachedItem) == 0) "The sellIn value cannot go below 0"
sellInReachedAndFullyDegraded = Test (std_sellIn (updateItem sellInReachedItem) == 0) "The sellIn value cannot go below 0 even if quality is 0"

-- Step 1 "Once the sell by date has passed, Quality degrades twice as fast"
sellInReachedQualityDegradesFaster = Test (std_quality (updateItem sellInReachedItem) == 3) "The quality of an item that already perished degrades twice as fast"

-- Step 2 "The Quality of an item is never negative"
fullyDegradedsellInReachedItem = StandardItem 2 0
fullyDegraded = Test (std_quality (updateItem fullyDegradedsellInReachedItem) == 0) "The quality of an item does not go below 0"

almostDegradedAndReachedSellInItem = StandardItem 0 1
almostDegradedAndReachedSellIn = Test (std_quality (updateItem almostDegradedAndReachedSellInItem) == 0) "An almost degraded item that already needed to be sold does not go to negative quality"

-- Step 3 "'Aged Brie' actually increases in Quality the older it gets"
agedBrie = AgedBrie 3 3
agedBrieReachedSellIn = AgedBrie 0 3
agedBrieQualityIncreases = Test (ab_quality (updateItem agedBrie) == 4) "The quality of AgedBrie increases"
agedBrieReachedSellInQualityIncreases = Test (ab_quality (updateItem agedBrieReachedSellIn) == 4) "The quality of AgedBrie increases even if it has reached its sellIn date"

-- Step 4 "The Quality of an item is never more than 50"
veryAgedBrie = AgedBrie 1 50
veryAgedBrieDoesNotIncreaseQuality = Test (ab_quality (updateItem veryAgedBrie) == 50) "The quality of AgedBrie does not exceed 50"

-- Step 5 "'Sulfuras', being a legendary item, never has to be sold or decreases in Quality"
sulfuras = Sulfuras 1 1
sulfurasDontExpire = Test (su_sellIn (updateItem sulfuras) == 1) "Sulfuras do not expire"
sulfurasDontDegrade = Test (su_quality (updateItem sulfuras) == 1) "Sulfuras do not degrade"

-- Step 6 "'Backstage passes', like aged brie, increases in Quality as it’s SellIn value approaches;
--        "Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert"
backStagePass = BackstagePasses 15 1
backStagePass10Days = BackstagePasses 10 1
backStagePass5Days = BackstagePasses 5 1
backStagePassAfterConcert = BackstagePasses 1 5

backStagePassLongBefore = Test (bp_quality (updateItem backStagePass) == 2) "Backstage passes slowly increase in quality long before the concert"
backStagePass10DaysBefore = Test (bp_quality (updateItem backStagePass10Days) == 3) "Backstage passes increase in quality quickly 10 days before the concert"
backStagePass5DaysBefore = Test (bp_quality (updateItem backStagePass5Days) == 4) "Backstage passes increase in quality rapidly 5 days before the concert"
backStagePassDegradesAfterConcert = Test (bp_quality (updateItem backStagePassAfterConcert) == 0) "Backstage passes lose quality immediately after the concert"

gildedRoseTest = [qualityDecreasesByOne,
			sellInDecreasesByOne,
			sellInReachedSellInRemainsZero,
			sellInReachedAndFullyDegraded,
			sellInReachedQualityDegradesFaster,
			fullyDegraded,
                  almostDegradedAndReachedSellIn,
			agedBrieQualityIncreases,
                  agedBrieReachedSellInQualityIncreases,
                  veryAgedBrieDoesNotIncreaseQuality,
                  sulfurasDontExpire,
                  sulfurasDontDegrade,
                  backStagePassLongBefore,
                  backStagePass10DaysBefore,
                  backStagePass5DaysBefore,
                  backStagePassDegradesAfterConcert]

