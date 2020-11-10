require 'pry'

class TicTacToe
    WIN_COMBINATIONS = 
       [[0,1,2],  # Top row
        [3,4,5],  # Middle row
        [6,7,8],  # Bottom row
        [0,4,8],  # Diagonal 1
        [2,4,6],  # Diagonal 2
        [0,3,6],  # Column 1
        [1,4,7],  # Column 2
        [2,5,8],] # Column 3
      
    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end
    
    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end
    
    def turn_count
        @board.count{|token| token == "X" || token == "O"}
    end
    
    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index,player = "X")
        @board[index] = player
    end

    def position_taken?(index)
        @board[index] == 'X' || @board[index] == 'O'
    end

    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
    end

    def turn
        puts "Please enter 1-9: "
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(index)
            move(index, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.detect do |win_combination|
          @board[win_combination[0]] == @board[win_combination[1]] &&
          @board[win_combination[1]] == @board[win_combination[2]] &&
          position_taken?(win_combination[0])
        end
    end    
    
    def full?
        turn_count == 9
    end

    def draw?
        !won? && full?
    end

    def over?
        won? || draw?
    end

    def winner
        if winner = won?
            @board[winner.first]
        end
    end

    def play
        until over?
          turn
        end
 
        if won?
          winner = winner()
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
    end
#game = TicTacToe.new
#game.play
end

