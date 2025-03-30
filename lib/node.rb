class Node
  include Comparable
  attr_accessor :data, :left, :right

  def <=>(other)
    data <=> other.data
  end

  def initialize(data, left=nil, right=nil)
    @data = data
    @left = left
    @right = right
  end

  def set_left(child)
    @left = child
  end

  def set_right(child)
    @right = child
  end

  def children_nil?
    return true if !@left && !@right
  end

  def child_hash()
    hash = {}
    hash[:left] = left if left
    hash[:right] = right if right
    return hash
  end

end
