{-# LANGUAGE NamedFieldPuns  #-}

module GildedRose where

data Item = Item { name :: String, sellIn :: Int, quality :: Int }
type Inventory = [Item]

processOneDay :: Inventory -> Inventory
processOneDay inventory = map updateItem inventory

updateItem :: Item -> Item
updateItem i@Item{name, sellIn, quality} 
    | stillValid && notDegraded = Item name (updateSellIn i) (updateQuality i)
    | stillValid = Item name (updateSellIn i) 0
    | notDegraded = Item name 0 (updateQuality i)
    | otherwise = Item name 0 0
    where stillValid = sellIn > 0
          notDegraded = quality > 0

updateQuality :: Item -> Int
updateQuality i@Item{name, sellIn, quality} 
    | name == "AgedBrie" = if quality < 50 then quality + 1 else 50
    | name == "Sulfuras" = quality
    | sellIn == 0 = if quality > 1 then quality - 2 else 0
    | otherwise = quality - 1

updateSellIn :: Item -> Int
updateSellIn i@Item{name, sellIn, quality}
    | name == "Sulfuras" = sellIn
    | otherwise = sellIn - 1
