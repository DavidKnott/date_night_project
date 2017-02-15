class BinaryTree

  attr_reader     :title,
                  :score

  attr_accessor   :left,
                  :right

  def initialize(score = nil, title = nil)
    @score = score
    @title = title
    @@counter = 0
  end

  def insert(score, title)
    check_for_root(score, title)
    case @score <=> score
      when 1 then insert_left(score, title)
      when -1 then insert_right(score, title)
    end
    depth_of(score)
  end

  def check_for_root(score, title)
    unless self.score
      @score = score
      @title = title
      return 0
    end
  end
        
  def insert_left(s, title)
    return left.insert(s, title) if left 
    self.left = BinaryTree.new(s, title)
  end

  def insert_right(s, title)
    return right.insert(s, title) if right 
    self.right = BinaryTree.new(s, title)
  end

  def include?(score)
    case @score <=> score
      when 1 then left.include?(score)
      when -1 then right.include?(score)
      when 0 then return true
    end
  end
        
  def depth_of(score_searched_for, depth = 0)
    @depth = depth
    case @score <=> score_searched_for
      when 1 
        left.depth_of(score_searched_for, depth + 1)  
      when -1
        right.depth_of(score_searched_for, depth + 1)
      when 0 then return depth
    end
  end
        
  def max(maximum = @score - 1, s = @score)
    maximum = @score if @score > maximum
    return right.max(maximum) if right
    {@title => @score}
  end

  def min(minimum = @score + 1, s = @score)
    minimum = @score if @score < minimum
    return left.min(minimum) if  left
    {@title => @score}
  end
        
  def sort(sorted = [])
    sorted.push({@title => @score})
    left.sort(sorted)  if left
    right.sort(sorted) if right
    sorted.sort_by do |movie|
      movie.values
    end
  end
        
  def load(file_name)
    counter = 0
    IO.foreach("#{file_name}") do |line|
      counter += 1
      line = line.split(',', 2)
      self.insert(line[0].to_i, line[1].strip)
      end
    counter
  end
        
  def health(level)
    scores_at_depth = self.find_scores_at_depth(level)  
    health_of_level = []
    scores_at_depth.each do |s|
      children = find_all_nodes_under(s)
      percent_health = calculate_health_as_percent(children)
      health_of_level.push([s, children, percent_health])
    end
    health_of_level
  end
        
  def find_scores_at_depth(depth_to_find, score_list = [], root = self)
    if root.depth_of(score) == depth_to_find
      score_list.push(score)
      return score_list if depth_to_find == 0
    end
    left.find_scores_at_depth(depth_to_find, score_list, root)  if left
    right.find_scores_at_depth(depth_to_find, score_list, root) if right
    score_list          
  end

  def find_all_nodes_under(start_score, root = self, start = false, node_list = [])
    start = true if score == start_score
    node_list.push('') if start
    left.find_all_nodes_under(start_score, root, start, node_list) if left
    right.find_all_nodes_under(start_score, root, start, node_list) if right
    node_list.length
  end

  def calculate_health_as_percent(children)
    children.to_f/self.sort.length
  end

  def leaves
    @@counter += 1 if left == nil && right == nil
    left.leaves if left
    right.leaves if right
    @@counter
  end

  def height
    list = self.sort
    height_list = []
    list.each do |elem|
      elem = elem.invert
      height_list.push(self.depth_of(elem.keys.first))
    end
    height_list.max
  end

  def top_five_movies
    list = self.sort
    recomendations = []
    1.upto(5) do |num|
      recomendations.push(list[-num])
    end
    recomendations
  end
end

tree = BinaryTree.new
tree.load('./lib/movies.txt')

p tree.top_five_movies



