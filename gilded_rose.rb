# frozen_string_literal: true

require 'delegate'
class BaseItemUpdater < SimpleDelegator
  def update; end

  private

  def update_quality(delta)
    next_value = quality + delta
    return if next_value > 50 || next_value.negative?

    self.quality = next_value
  end
end

class AgedBrieUpdater < BaseItemUpdater
  def update
    self.sell_in -= 1
    update_quality(1)
    update_quality(1) if expired?
  end
end

class BackStagePassUpdater < BaseItemUpdater
  def update
    self.sell_in -= 1
    update_quality(1)
    update_quality(1) if sell_in < 11
    update_quality(1) if sell_in < 6

    update_quality(-quality) if expired?
  end
end

class NormalUpdater < BaseItemUpdater
  def update
    self.sell_in -= 1
    update_quality(-1)
    update_quality(-1) if expired?
  end
end

class GildedRose
  AGE_BRIE = 'Aged Brie'
  BACKSTAGE_PASSESS = 'Backstage passes to a TAFKAL80ETC concert'
  SULFURAS = 'Sulfuras, Hand of Ragnaros'

  ITEM_UPDATER_LOOKUP = {
    'Aged Brie' => AgedBrieUpdater,
    'Backstage passes to a TAFKAL80ETC concert' => BackStagePassUpdater,
    'Sulfuras, Hand of Ragnaros' => BaseItemUpdater
  }.freeze

  DEFAULT_UPDATER = NormalUpdater

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
    updater_klass = ITEM_UPDATER_LOOKUP.fetch(item.name, DEFAULT_UPDATER)
    updater_klass.new(item).update
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def expired?
    sell_in.negative?
  end

  def to_h
    { name: @name, sell_in: @sell_in, quality: @quality }
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
