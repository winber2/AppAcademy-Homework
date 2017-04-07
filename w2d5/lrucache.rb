class LRUCache
  attr_reader :cache

  def initialize(size = 4)
      @size = size
      @cache = []
  end

  def count
    @cache.count
    # returns number of elements currently in cache
  end

  def add(el)
    if @cache.include?(el)
      @cache.delete(el)
      @cache.push(el)
    else
      @cache.push(el)
      @cache.shift if count > @size
    end
    el
    # adds element to cache according to LRU principle
  end

  def show
    p @cache
    nil
    # shows the items in the cache, with the LRU item first
  end

  private
  # helper methods go here!

end
