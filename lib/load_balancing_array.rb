# encoding: UTF-8
class LoadBalancingArray

  def initialize(size)
    @size = size
    @piles = []
    (0..size-1).each{|i| @piles[i] = []}
  end

  attr_reader :piles, :size

  def add(item)
    return if item.nil?

    if empty?
      spread([item])
    else
      smallest_pile << item
    end
  end

  def spread(items)
    nb_items = items.size
    return if nb_items == 0

    step = 2
    if empty?
      first_index = first_index_when_empty(nb_items)
      items.each_with_index do |item, index|
        piles[(first_index + index*step) % size] << item
      end
    else
      items.each do |item|
        smallest_pile << item
      end
    end
  end

  def pile_sizes
    piles.map{|pile| pile.size}
  end

  def empty?
    tallest_pile.empty?
  end

  private

  def first_index_when_empty(nb_items)
    case nb_items
    when 1
      size/2
    when 2
      size/2 - 1
    when 3
      size/3 - 1
    else
      0
    end
  end

  def smallest_pile
    piles.min_by{|pile| pile.size}
  end

  def tallest_pile
    piles.max_by{|pile| pile.size}
  end
end
