class TicTacToe
    #require pry
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]
    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " " ]
    end
    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} " 
    end
    def input_to_index(player_choice)
        player_choice = player_choice.to_i
        board_spot = player_choice -1
        return board_spot         
    end
    def move(board_index, player_token = "X")
        @board[board_index] = player_token
    end
    def position_taken?(player_choice)
        @board[player_choice] == "X" || @board[player_choice] == "O"
    end
    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
      end
    def turn_count
        counter = 0
        @board.each do |space|
            if space == "X" || space == "O"
                counter += 1
            end
        end
        return counter
    end
    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end
    def turn
        puts "please choose a position between 1-9"
        player_input = gets.strip
        move = input_to_index(player_input)
        if valid_move?(move)
            move(move, current_player)
            display_board
        else
            turn
        end
    end
    def x_position
        x_spot = @board.map {|spot| spot == "X"}
        x_spot
    end
    def o_position
        o_spot = @board.map {|spot| spot == "O"}
        o_spot
    end
    def full?
        @board.all? {|i| i== "X" || i == "O"}
    end
    
    def won?
        WIN_COMBINATIONS.each do |winning_combo|
            index_0 = winning_combo[0]
            index_1 = winning_combo[1]
            index_2 = winning_combo[2]

            position_1 = @board[index_0]
            position_2 = @board[index_1]
            position_3 = @board[index_2]
            
            if position_1 == "X" && position_2 == "X" && position_3 == "X"
                return winning_combo
              elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
                return winning_combo
            end
        end
        return false
    end
    def draw?
        if !won? && full?
            return true
        else
            false
        end
    end
    def over?
        if won? || draw?
            true
        end
    end
    def winner
        find_win_combo = []
        find_win_combo = won?
        if find_win_combo == false
            return nil
        else
            if @board[find_win_combo[0]] == "X"
                return "X"
            else
                return "O"
            end
        end
    end
    def play
          until over? == true
              turn
          end
          if won?
              puts "Congratulations #{winner}!"
          elsif draw?
              puts "Cat's Game!"
          end
    end
end

