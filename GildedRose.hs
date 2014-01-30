{-# LANGUAGE NamedFieldPuns  #-}

module GildedRose where

data Item = Item { name :: String, sellIn :: Int, quality :: Int }
type Inventory = [Item]

processOneDay :: Inventory -> Inventory
processOneDay inventory = map updateItem inventory

updateItem :: Item -> Item
updateItem i@Item{name, sellIn, quality} 
    | stillValid && notDegraded = Item name (sellIn - 1) (updateQuality i)
    | stillValid = Item name (sellIn - 1) 0
    | notDegraded = Item name 0 (updateQuality i)
    | otherwise = Item name 0 0
    where stillValid = sellIn > 0
          notDegraded = quality > 1

updateQuality :: Item -> Int
updateQuality i@Item{name, sellIn, quality} 
    | name == "AgedBrie" = if quality < 50 then quality + 1 else 50
    | sellIn == 0 = quality - 2
    | otherwise = quality - 1
