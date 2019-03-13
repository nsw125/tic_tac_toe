class Game

    def initialize
        puts "Enter a name for player one."
        @player1 = Player.new(gets.chomp)
        puts "Enter a name for player two."
        @player2 = Player.new(gets.chomp)
        puts "Our players are: #{@player1.name} and #{@player2.name}! Let's see who gets to decide turn order..."
        puts
        puts

        coin_flip = rand(1..2)
        if coin_flip == 1
            @current_player = @player1
            symbol_chooser = @player2
        else
            @current_player = @player2
            symbol_chooser = @player1
        end

        puts "#{@current_player.name} wins the toss, and gets to go first!"
        puts "But first, #{symbol_chooser.name}, would you like to be X's or O's? Enter (x/o)"
        symbol = gets.chomp.downcase
        until symbol == 'x' or symbol == 'o'
            puts "You can't enter that, enter x or o."
            symbol = gets.chomp
        end
        symbol == 'x' ? other_symbol = 'o' : other_symbol = 'x'
        @current_player.symbol = other_symbol
        @current_player == @player1 ? @player2.symbol = symbol : @player1.symbol = symbol
        puts "#{symbol_chooser.name} will be #{symbol_chooser.symbol.upcase}'s and #{@current_player.name} will be #{@current_player.symbol.upcase}'s"
        puts

        @boxes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        @boxes[0] = 'a'
        @row1 = @boxes[1..3]
        @row2 = @boxes[4..6]
        @row3 = @boxes[7..9]

        @winner = nil
    end

    def play_game
        while @winner == nil
            player_turn
        end
    end

    def show_board

        @row1 = @boxes[1..3]
        @row2 = @boxes[4..6]
        @row3 = @boxes[7..9]

        puts "  " + @row1.join('  |  ')
        puts "-----------------"
        puts "  " + @row2.join('  |  ')
        puts "-----------------"
        puts "  " + @row3.join('  |  ')
    end

    def player_turn
        puts "#{@current_player.name}, it's your turn!"
        puts "Pick any open square by entering the number shown inside of it."
        player_entry = gets.chomp.to_i
        until @boxes[player_entry] != 0 and @boxes[player_entry].is_a? Integer
            puts 'that is not a valid option'
            player_entry = gets.chomp.to_i
        end
        @boxes[player_entry] = @current_player.symbol
        show_board
        win_checker
        @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
        
    end

    def win_checker
        if    @boxes[1] == @boxes[2] and @boxes[2] == @boxes[3]      #Horizontal Wins
            @winner = @boxes[1]
        elsif @boxes[4] == @boxes[5] and @boxes[5] == @boxes[6]
            @winner = @boxes[4]
        elsif @boxes[7] == @boxes[8] and @boxes[8] == @boxes[9]
            @winner = @boxes[7]
        elsif @boxes[1] == @boxes[5] and @boxes[5] == @boxes[9]      #Diagonal Wins
            @winner = @boxes[1]
        elsif @boxes[3] == @boxes[5] and @boxes[5] == @boxes[7]
            @winner = @boxes[3]
        elsif @boxes[1] == @boxes[4] and @boxes[4] == @boxes[7]      #Vertical wins
            @winner = @boxes[1]
        elsif @boxes[2] == @boxes[5] and @boxes[5] == @boxes[8]
            @winner = @boxes[2]
        elsif @boxes[3] == @boxes[6] and @boxes[6] == @boxes[9]
            @winner = @boxes[3]
        elsif @boxes.all? String
            @winner = false
            puts "Its a cat! No winner.."
        end

        if @winner == 'x' or @winner == 'o'
            if @winner == @player1.symbol 
                puts "#{@player1.name} is the winner!" 
            else
                puts "#{@player2.name} is the winner!"
            end
        end
    end
end

class Player

    attr_accessor :name, :symbol

    def initialize(name, symbol=nil)
        @name = name
        @symbol = symbol

    end
end

game = Game.new
game.show_board
game.play_game