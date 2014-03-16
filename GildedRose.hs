{-# LANGUAGE NamedFieldPuns  #-}

module GildedRose where

class Item i where
    updateQuality :: i -> Int
    updateSellIn :: i -> Int
    updateItem :: i -> i

data StandardItem = StandardItem { std_sellIn :: Int, std_quality :: Int }
data AgedBrie = AgedBrie { ab_sellIn :: Int, ab_quality :: Int }
data Sulfuras = Sulfuras { su_sellIn :: Int, su_quality :: Int }
data BackstagePasses = BackstagePasses { bp_sellIn :: Int, bp_quality :: Int }

instance Item StandardItem where
    updateQuality s@StandardItem{std_sellIn, std_quality}  = if std_sellIn <= 0 then std_quality - 2 else std_quality - 1
    updateSellIn s@StandardItem{std_sellIn, std_quality} = std_sellIn - 1
    updateItem s@StandardItem{std_sellIn, std_quality} = StandardItem (us $ updateSellIn s) (uq $ updateQuality s)

instance Item AgedBrie where
    updateQuality a@AgedBrie{ab_sellIn, ab_quality} = ab_quality + 1
    updateSellIn a@AgedBrie{ab_sellIn, ab_quality} = ab_sellIn - 1
    updateItem a@AgedBrie{ab_sellIn, ab_quality} = AgedBrie (us $ updateSellIn a) (uq $ updateQuality a)

instance Item Sulfuras where
    updateQuality s@Sulfuras{su_sellIn, su_quality} = su_quality
    updateSellIn s@Sulfuras{su_sellIn, su_quality} = su_sellIn
    updateItem su@Sulfuras{su_sellIn, su_quality} = Sulfuras (us $ updateSellIn su) (uq $ updateQuality su)

instance Item BackstagePasses where
    updateQuality b@BackstagePasses{bp_sellIn, bp_quality}
        | bp_sellIn > 10 = bp_quality + 1
        | bp_sellIn > 5 && bp_sellIn <= 10 = bp_quality + 2
        | bp_sellIn > 0 && bp_sellIn <= 5 = bp_quality + 3
        | bp_sellIn <= 0 = 0
    updateSellIn b@BackstagePasses{bp_sellIn, bp_quality} = bp_sellIn - 1
    updateItem b@BackstagePasses{bp_sellIn, bp_quality} = BackstagePasses newSellIn newQuality where
        newSellIn = us $ updateSellIn b
        newQuality = uq $ updateQuality (BackstagePasses newSellIn bp_quality)

us :: Int -> Int
us sellIn = if sellIn <= 0 then 0 else sellIn

uq :: Int -> Int
uq quality
    | quality > 50 = 50
    | quality <= 0 = 0
    | otherwise = quality
