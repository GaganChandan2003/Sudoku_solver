module Api
  class SudokuController < ApplicationController

    #GET Request
    def index
      render :json => { :status => "SUCCESS" }
    end

    #POST Request
    def create
      board = params.require(:data) 
      @n=9
      def sudoku(board, row, col)
        if row ==  @n-1 && col ==  @n 
          return true
        end
        if col ==  @n            
          row = row + 1
          col = 0
        end
        if board[row][col] != 0
          return sudoku(board, row, col + 1) 
        end
        for i in 1... @n+1
          if issafe(board, row, col, i) == true  
            board[row][col] = i             
            if sudoku(board, row, col + 1) === true  
              return true
            end
          end
          board[row][col] = 0
        end
        return false
      end

      def issafe(board, row, col, num)
        for x in 0... @n
          if board[row][x] == num
            return false
          end
        end
        for x in 0... @n
          if board[x][col] == num
            return false
          end
        end
        sr = row - row % 3
        sc = col - col % 3
        for i in 0...3
          for j in 0...3
            if board[i + sr][j + sc] == num
              return false
            end
          end
        end
        return true
      end
      if sudoku(board, row = 0, col = 0) == true #Passing matrix with row and column
        render :json => { :status => "SUCCESS",:messege=>"Sudoku solved",:data => board }
      else
        render :new, status: :unprocessable_entity
      end
    end
  end
end
