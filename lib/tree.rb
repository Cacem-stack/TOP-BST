require_relative "node.rb"

class Tree
  attr_accessor :root

  @root = nil


  def build_tree(array, st=0, en=array.length - 1)
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

  def insert()
  end

  def find(n)
    traverse { |node|
      if n == node.data
        puts "value present"
        yield node if block_given?
        return node
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

  def to_a(n)
    array = [n]
    traverse { |node|
      array.push(node.data)
    }
    return array
  end


end

# sort array (and remove duplicates)

# take sorted array

# assign root to middle of sorted array

