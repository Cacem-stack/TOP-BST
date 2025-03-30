require_relative "lib/node.rb"
require_relative "lib/tree.rb"

arr = (Array.new(15) { rand(1..100) })

tree = Tree.new(arr)

balanced = lambda { puts "tree balanced? #{tree.balanced?}" }

balanced.call

tree.order("pre")
tree.order("in")
tree.order("post")
tree.level_order_print
#
ext_arr = *(101..115)

for each in ext_arr
  tree.insert(each)
end

balanced.call
tree.rebalance

balanced.call
tree.order("pre")
tree.order("in")
tree.order("post")
tree.level_order_print
