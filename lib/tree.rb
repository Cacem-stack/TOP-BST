require_relative "node.rb"

class Tree
attr_accessor :root


  def initialize(array)
    @root = nil
    array = array.sort.uniq
    build_tree(array)
  end

  def build_tree(array, st=0, en=array.length - 1)


    return nil if st > en
    mid = (st + en) / 2

    root = Node.new(array[mid])
    @root = root if !@root

    root.set_left(build_tree(array, st, mid - 1))
    root.set_right(build_tree(array, mid + 1, en))

    return root if !root
    return root if @root != root
    pretty_print(root) if root == @root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end


  def delete(n)
    change_made = false
    traverse { |node|
      if node.right == n
        change_made = true
        if node.right.children_nil?
          node.right = nil
          return
        else
          hash = node.right.child_hash
          node.right = hash[:right] if hash[:right]
          node.left = hash[:left] if hash[:left]
        end
      elsif node.left == n
        change_made = true
        if node.left.children_nil?
          node.left = nil
          return
        else
          hash = node.left.child_hash
          node.left = hash[:left] if hash[:left]
          node.right = hash[:right] if hash[:right]
        end
      end
      puts "Value not present" if !change_made
    }
  end

  def rebalance()
    build_tree(to_a(true))
  end

  def find(n)
    traverse { |node|
      if n == node.data
        yield node if block_given?
      else
      end
      puts "value not present"
      return false
    }
  end

  def to_a(reset = nil, n = nil)
    array = [] if !n
    traverse { |node|
      array.push(node.data) if node
    }
    @root = nil if reset
    return array
  end

  def insert(n, node=@root)

    return if node.data == nil

    if !node.right && n > node.data
      node.right = Node.new(n)
      return true
    elsif !node.left && n < node.data
      node.left = Node.new(n)
      return true
    else
    end

    if n == node.data
      puts "Value present"
      return false
    elsif n < node.data && node.left
      insert(n, node.left)
    elsif n > node.data && node.right
      insert(n, node.right)
    end

  end

  def traverse(root = @root, &block)
    return if !root
    yield(root)
    traverse(root.left, &block) if root.left
    traverse(root.right, &block) if root.right
  end

  def height()
    return level_order.recursive_helper.length - 1
  end

  def depth(node)
    level_order.recursive_helper { |root, level|
      return level - 1 if node == root.data
    }
  end

  def balanced?(root=@root, level=0)
    return if !root
    lev_left = balanced?(root.right, level+1) if root.right
    lev_right = balanced?(root.left, level+1) if root.left
    if root != @root
      if lev_left.to_f >= lev_right.to_f
        level = lev_left if lev_left
        return level
      elsif lev_left.to_f < lev_right.to_f
        level = lev_right if lev_right
        return level
      end

    elsif root == @root
      return true if (lev_left - lev_right).abs <= 1
      return false if (lev_left - lev_right).abs > 1
    end

  end

  def level_order_iteration()
    root = @root
    node_arr = []
    node_arr += root.child_hash.values
    yield(root)

    root = node_arr.shift

    until node_arr.length == 0
      yield(root)
      node_arr += root.child_hash.values
    end
  end

  def level_order_recursive_helper(root=@root, level=0, lev_arr=[])
    return if !root
    lev_arr[0] = [root.data] if lev_arr.length == 0

    root.child_hash.values.each do |value|
    lev_arr[0] = [root.data] if lev_arr.length == 0

    lev_arr[level] = [value.data] if !lev_arr[level] && value.data
    lev_arr[level] += [value.data] if lev_arr[level] && value.data
    end

    level_order_recursive_helper(root.left, level+1, lev_arr)
    level_order_recursive_helper(root.right, level+1, lev_arr)

    return lev_arr.flatten.uniq
  end

  def level_order_recursive()
    lev_arr = level_order_recursive_helper

    for ele_arr in lev_arr
      for ele in ele_arr
        yield(ele)
      end
    end
  end

  def mixed(root = @root, node_arr = [])
    node_arr += root.child_hash.values if
    yield(root)
    root = node_arr.shift
    level_order_mixed(root, node_arr)
  end

  def level_order_print()
    puts "level-order array: #{level_order_recursive_helper.to_s}"
  end

  def order(type, &block)
    if block_given?
      case type
      when "pre"
        pre(&block)
      when "in"
        in_ord(&block)
      when "post"
        post(&block)
      end
      return

    else
      case type
      when "pre"
        array = []
        pre { |node|
          array.push(node.data) if node.data != nil
        }
      when "in"
        array = []
        in_ord { |node|
          array.push(node.data) if node.data != nil
        }
      when "post"
        array = []
        post { |node|
          array.push(node.data) if node.data != nil
        }
      end
      puts "#{type}-order array: #{array.to_s}"

    end
  end

  def pre(root = @root, &block)
    return if !root
    yield(root)
    pre(root.left, &block) if root.left
    pre(root.right, &block) if root.right
  end

  def in_ord(root = @root, &block)
    return if !root
    in_ord(root.left, &block) if root.left
    yield(root)
    in_ord(root.right, &block) if root.right
  end

  def post(root = @root, &block)
    return if !root
    post(root.left, &block) if root.left
    post(root.right, &block) if root.right
    yield(root)
  end

end
