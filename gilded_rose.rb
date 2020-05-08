# frozen_string_literal: true

class GildedRose
  AGE_BRIE = 'Aged Brie'
  BACKSTAGE_PASSESS = 'Backstage passes to a TAFKAL80ETC concert'
  SULFURAS = 'Sulfuras, Hand of Ragnaros'

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      update_item(item)
    end
  end

  private

  def update_item(item)
    if item.name == AGE_BRIE
      update_item_quality(item, 1)
    elsif item.name == BACKSTAGE_PASSESS
      update_item_quality(item, 1)
      update_item_quality(item, 1) if item.sell_in < 11
      update_item_quality(item, 1) if item.sell_in < 6
    elsif item.name != SULFURAS
      update_item_quality(item, -1)
    end

    item.sell_in = item.sell_in - 1 if item.name != SULFURAS

    if item.sell_in.negative?
      if item.name == AGE_BRIE
        update_item_quality(item, 1)
      elsif item.name == BACKSTAGE_PASSESS
        update_item_quality(item, -item.quality)
      elsif item.name == SULFURAS

      else
        update_item_quality(item, -1)
      end
    end
  end

  def update_item_quality(item, quality)
    next_value = item.quality + quality
    return if next_value > 50 || next_value.negative?

    item.quality += quality
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_h
    { name: @name, sell_in: @sell_in, quality: @quality }
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
