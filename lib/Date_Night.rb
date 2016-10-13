require "pry"

class BinaryTree

            
        attr_reader     :title

        attr_accessor   :left,
                        :right,
                        :score

        def initialize(score = nil, title = nil)
            @score = score
            @title = title
            @@counter = 0
           
        end

        def insert(s, title)
            if self.score == nil
                @score = s
                @title = title
                return 0
            end
            case @score <=> s
            when 1 then insert_left(s, title)
            when -1 then insert_right(s, title)
            end
            return depth_of(s)
        end

        def insert_left(s, title)
            if left 
                left.insert(s, title)
            else
                self.left = BinaryTree.new(s, title)
            end
        end

        def insert_right(s, title)
            if right 
                right.insert(s, title)
            else
                self.right = BinaryTree.new(s, title)
            end
        end

        def include?(s)
            case @score <=> s
            when 1 then left.include?(s)
            when -1 then right.include?(s)
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
            maximum = maximum
            if @score > maximum
                maximum = @score
            end
            if right != nil
                right.max(maximum)
            else 
                return {@title => @score}
            end
        end
        

        def min(minimum = @score + 1, s = @score)
            if @score < minimum
                minimum = @score
            end
            if  left != nil
                left.min(minimum)
            else 
                return {@title => @score}
            end
        end
        
        def sort(sorted = [])
            sorted.push({@title => @score})
            if left
                left.sort(sorted)
            end
            if right
                right.sort(sorted)
            end
            sorted = sorted.sort_by do |movie|
                movie.values
            end
            return sorted
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
            if left
                left.find_scores_at_depth(depth_to_find, score_list, root)
            end
            if right
                right.find_scores_at_depth(depth_to_find, score_list, root)
            end
            score_list          
        end

        def find_all_nodes_under(start_score, root = self, start = false, node_list = [])
            if score == start_score
                start = true
            end
            node_list.push('') if start
            if left
                left.find_all_nodes_under(start_score, root, start, node_list)
            end
            if right
                right.find_all_nodes_under(start_score, root, start, node_list)
            end            
            node_list.length
        end

        def calculate_health_as_percent(children)
            health_percent = children.to_f/self.sort.length
            health_percent
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
tree.load('movies.txt')

p tree.top_five_movies



