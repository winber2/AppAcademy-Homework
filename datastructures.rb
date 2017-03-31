class Stack
  attr_accessor :stack

  def initialize
    @stack = []
  end

  def add(el)
    @stack << el
    el
  end

  def remove
    @stack.pop
  end

  def show
    @stack.dup
  end
end

class Queue
  attr_accessor :queue

  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue << el
    el
  end

  def dequeue
    @queue.shift
  end

  def show
    @queue.dup
  end
end

class Map
  attr_accessor :map

  def initialize
    @map = []
  end

  def assign(key, value)
    @map.each_index {|idx| map.delete_at(idx) if map[idx][0] == key}
    @map << [key, value]
    [key,value]
  end

  def lookup(key)
    @map.each {|el| return el[1] if el[0] == key}
    nil
  end

  def remove(key)
    @map.each_index {|idx| @map.delete_at(idx) if @map[idx][0] == key}
    nil
  end

  def show
    @map.map {|el| el.dup}.dup
  end
end
