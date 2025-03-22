require_relative "node.rb"

class Tree
  attr_accessor :root


  def initialize(array)
    build_tree(array)
  end

  def build_tree(array, st=0, en=array.length - 1)
    @root = nil
    array = array.sort.uniq

    return nil if st > en
    mid = (st + en) / 2

    root = Node.new(array[mid])
    @root = root if !@root

    root.set_left(build_tree(array, st, mid - 1))
    root.set_right(build_tree(array, mid + 1, en))

    pretty_print(root) if root == @root
    return root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(n)
    traverse { |node|
      if n == node.data
        puts "Value present"
        return
      elsif n < node.data && !node.left
        node.left = Node.new(n)
      elsif n > node.data && !node.right
        node.right = Node.new(n)
      end
    }
  end

  def delete(n)
    change_made? = false
    traverse { |node|
      if node.right == n
        change_made? = true
        if node.right.children_nil?
          node.right = nil
          return
        else
          hash = node.right.child_hash
          node.right = hash[:right] if hash[:right]
          node.left = hash[:left] if hash[:left]
        end
      elsif node.left == n
        change_made? = true
        if node.left.children_nil?
          node.left = nil
          return
        else
          hash = node.left.child_hash
          node.left = hash[:left] if hash[:left]
          node.left = hash[:left] if hash[:left]
        end
      end
      puts "Value not present" if !change_made?
    }
  end


  def rebalance()
    build_tree(to_a)
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

  def traverse(root = @root)
    yield root
    traverse(root.right) if root.right
    traverse(root.left) if root.left
  end

  def to_a(n = nil)
    array = [] if !n
    traverse { |node|
      array.push(node.data)
    }
    return array
  end


end

# sort array (and remove duplicates)

# take sorted array

# assign root to middle of sorted array

