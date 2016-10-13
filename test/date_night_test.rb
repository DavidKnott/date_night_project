gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './date_night.rb'

#1 to 1 tests for methods
class DateNightTest < Minitest::Test
    def test_it_exists
        tree = BinaryTree.new(10, "hey")
        assert_equal BinaryTree, tree.class
    end 
    def test_initialize_data_score
        tree = BinaryTree.new(10, "hey")
        assert_equal 10, tree.score
    end
    def test_initialize_data_title
    tree = BinaryTree.new(10, "hey")
    assert_equal "hey", tree.title
    end

    def test_insert_new_node_left
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    tree.insert(25,"Taledega Nights")
    assert_equal "Taledega Nights", tree.left.title
    end

    def test_insert_new_node_right
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    tree.insert(75,"Taledega Nights")
    assert_equal "Taledega Nights", tree.right.title
    end

    def test_include_root
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    assert_equal true, tree.include?(50)
    end

    def test_inlude_check_left
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    tree.insert(25,"Taledega Nights")
    assert_equal true, tree.include?(25)
    end

    def test_inlude_check_right
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    tree.insert(75,"Taledega Nights")
    assert_equal true, tree.include?(75)
    end

    def test_depth_of_for_root
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    assert_equal 0, tree.depth_of(50)
    end

    def test_depth_of_for_left
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    tree.insert(25,"Taledega Nights")
    assert_equal 1, tree.depth_of(25)
    end

    def test_depth_of_for_right
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    tree.insert(75,"Taledega Nights")
    assert_equal 1, tree.depth_of(75)
    end


    def test_max_for_root
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    assert_equal [50], tree.max.values
    end

    def test_max_for_another_node
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    tree.insert(75, "Taledega Nights")
    tree.insert(25, "Spongebob Movie")
    assert_equal [75], tree.max.values
    end

    def test_min_for_root
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    assert_equal [50], tree.min.values
    end

    def test_min_for_another_node
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    tree.insert(75,"Taledega Nights")
    tree.insert(25,"Spongebob Movie")
    assert_equal [25], tree.min.values
    end

    def test_sort_one_value
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    assert_equal ["Story of my life"], tree.sort[0].keys
    end

    def test_sort_multiple_values
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    tree.insert(75,"Taledega Nights")
    tree.insert(25,"Spongebob Movie")
    assert_equal ["Taledega Nights"], tree.sort[2].keys
    end

    def test_load_for_multiple_values
    tree = BinaryTree.new
    assert_equal 99, tree.load("movies.txt")
    end

    def test_health_for_root_node
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    assert_equal [[50, 1, 1.0]], tree.health(0)
    end

    def test_health_for_other_nodes
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    tree.insert(75,"Taledega Nights")
    tree.insert(25,"Spongebob Movie")
    assert_equal [[25, 1, 0.3333333333333333], [75, 1, 0.3333333333333333]], tree.health(1)
    end

    def test_for_root_node_leave
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    assert_equal 1, tree.leaves
    end

    def test_for_other_leaves
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    tree.insert(75,"Taledega Nights")
    tree.insert(25,"Spongebob Movie")
    assert_equal 2, tree.leaves
    end

    def test_for_root_node_height
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    assert_equal 0, tree.height
    end

    def test_for_other_height
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    tree.insert(75,"Taledega Nights")
    tree.insert(25,"Spongebob Movie")
    assert_equal 1, tree.height
    end

    def test_top_five_recomendation
    tree = BinaryTree.new
    tree.insert(50, "Story of my life")
    tree.insert(99, "Jungle Book")
    tree.insert(87, "Lion King")
    tree.insert(75,"Taledega Nights")
    tree.insert(25,"Spongebob Movie")
    tree.insert(64,"Braveheart")
    assert_equal [{"Jungle Book"=>99}, {"Lion King"=>87}, {"Taledega Nights"=>75}, {"Braveheart"=>64}, {"Story of my life"=>50}], tree.top_five_movies
    end
end

