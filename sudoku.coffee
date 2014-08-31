# Sudocoffee
# ==========
#
# Simple backtracking Sudoku solver written in Coffeescript

# Board
# -----
# 
# `Board` is the immutable state of a Sudoku board.
class Board

        # Thrown when a manipulation would result in a violation of rules
        class InvalidBoardError extends Error
                constructor: ->

        # `ZONES` are regions in the grid in which no number can occur twice or more
        ZONES = do ->
                zones = []
                # Initialize columns
                zones.push ([x, y] for x in [0..8]) for y in [0..8]
                # Initialize rows
                zones.push ([x, y] for y in [0..8]) for x in [0..8]
                # Initialize 3x3 sub squares
                for x in [0, 3, 6]
                        for y in [0, 3, 6]
                                zone = []
                                zone.push [x + i, y + j] for i in [0..2] for j in [0..2]
                                zones.push(zone)
                zones

        # Construct an empty board, or copy the state from *other*
        constructor: (other=null) ->
                @board = (
                        (null for x in [0..8]) for y in [0..8]
                )
                if other isnt null
                        @board[y][x] = other.board[y][x] for x in [0..8] for y in [0..8]

        # Return a new board, which has the field at (`x`, `y`) set to `num`. Throws an `InvalidBoardError` if this new board would be invalid
        set: (x, y, num) ->
                for zone in ZONES
                        containsXY = false
                        containsNum = false
                        for [_x, _y], _ in zone
                                containsXY ||= _x == x and _y == y
                                containsNum ||= @board[_y][_x] == num
                        throw new InvalidBoardError if containsXY and containsNum
                
                newBoard = new Board(this)
                newBoard.board[y][x] = num
                newBoard

        # **Solve** the board with a simple backtracking algorithm. Returns the solved board, or `null` if there is no solution.
        solve: ->                        
             
                # Pick a free field to try all values for.
                that = this
                freeField = do ->
                        for x in [0..8]
                                for y in [0..8]
                                        return [x, y] if that.board[y][x] is null
                        null

                # If there are no free fields, the board is already solved!
                if freeField is null
                        return this

                # Try all numbers between 1 .. 9 if they result in a valid board, then solve recursively
                [x, y] = freeField
                for num in [1..9]
                        try
                                newBoard = @set x, y, num
                        catch ex
                                if ex instanceof InvalidBoardError
                                        continue
                                else
                                        throw ex
                        solution = newBoard.solve()
                        # Eagerly return the first valid solution that is found
                        if solution isnt null
                                return solution
 
                # This board has no solution!
                null

exports.Board = Board
              
