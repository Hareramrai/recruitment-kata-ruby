require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    let(:sell_in) { 10 }
    let(:quality) { 5 }
    let(:name) { 'My item' }
    let(:item) { Item.new(name, sell_in, quality) }

    context 'when the item is "normal"' do
      context 'before expired' do
        it 'reduces the quality by one' do
          GildedRose.new([item]).update_quality

          expect(item.quality).to eq(quality - 1)
        end
      end

      context 'after expired' do
        let(:sell_in) { 0 }

        it 'reduces the quality by two' do
          GildedRose.new([item]).update_quality

          expect(item.quality).to eq(quality - 2)
        end
      end

      context 'when quality is zero' do
        let(:quality) { 0 }

        it 'never goes below zero' do
          GildedRose.new([item]).update_quality

          expect(item.quality).to eq(0)
        end
      end
    end


    context 'when the item is "Aged Brie"' do
      let(:name) { 'Aged Brie' }

      context 'when sell_in is greater than 0' do
        it 'increase the quality by one' do
          GildedRose.new([item]).update_quality

          expect(item.quality).to eq(quality + 1)
        end
      end

      context 'when sell_in is after 0' do
        let(:sell_in) { 0 }

        it 'increase the quality by two' do
          GildedRose.new([item]).update_quality

          expect(item.quality).to eq(quality + 2)
        end
      end

      context 'when quality is 50' do
        let(:quality) { 50 }

        it 'quality never goes above 50' do
          GildedRose.new([item]).update_quality

          expect(item.quality).to eq(50)
        end
      end
    end

    context 'when the item is "Backstage passes"' do
      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }

      context 'when sell_in is more than 10 days' do
        let(:sell_in) { 11 }

        it 'increases the quality by one' do
          GildedRose.new([item]).update_quality

          expect(item.quality).to eq(quality + 1)
        end
      end

      context 'when sell_in is between 10 and 6 days' do
        let(:sell_in) { 10 }

        it 'increases the quality by two' do
          GildedRose.new([item]).update_quality

          expect(item.quality).to eq(quality + 2)
        end
      end

      context 'when sell_in is between 5 and 1 days' do
        let(:sell_in) { 4 }

        it 'increases the quality by three' do
          GildedRose.new([item]).update_quality

          expect(item.quality).to eq(quality + 3)
        end
      end

      context 'when sell_in on or after 0 days' do
        let(:sell_in) { 0 }

        it 'quality goes to zero' do
          GildedRose.new([item]).update_quality

          expect(item.quality).to eq(0)
        end
      end
    end

    context 'when the item is "Sulfuras"' do
      let(:name) { 'Sulfuras, Hand of Ragnaros' }

      it 'quality and sell_in never changes' do
        GildedRose.new([item]).update_quality

        expect(item.quality).to eq(quality)
        expect(item.sell_in).to eq(sell_in)
      end
    end
  end
end
