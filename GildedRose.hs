{-# LANGUAGE NamedFieldPuns  #-}

module GildedRose where

data Item = Item { name :: String, sellIn :: Int, quality :: Int }
type Inventory = [Item]

processOneDay :: Inventory -> Inventory
processOneDay inventory = map updateQuality inventory

updateQuality :: Item -> Item
updateQuality i@Item{name, sellIn, quality} 
	| stillValid && notDegraded = Item name (sellIn - 1) (quality - 1)
	| stillValid = Item name (sellIn - 1) 0
	| notDegraded = Item name 0 (quality - 2)
	| otherwise = Item name 0 0
	where stillValid = sellIn > 0
	      notDegraded = quality > 1
