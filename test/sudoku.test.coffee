
{Board} = require "../sudoku"

exports.BoardTest =

        "manipulation via set": (test) ->
                board = (new Board)
                        .set 0, 0, 1
                        .set 8, 8, 1
                test.equal board.board[0][0], 1
                test.equal board.board[8][8], 1
                test.equal board.board[1][1], null
                test.done()

        "reject invalid states": (test) ->
                board = (new Board)
                        .set 0, 0, 1
                # same row:
                test.throws -> board.set 8, 0, 1
                # same column:
                test.throws -> board.set 0, 8, 1
                # same 3x3 sub square:
                test.throws -> board.set 2, 2, 1
                test.done()

        "solve empty board": (test) ->
                test.doesNotThrow -> (new Board).solve()
                test.done()

        "solve full example": (test) ->
                board = (new Board)
                        .set 0, 0, 5
                        .set 1, 0, 3
                        .set 4, 0, 7
                        .set 0, 1, 6
                        .set 3, 1, 1
                        .set 4, 1, 9
                        .set 5, 1, 5
                        .set 1, 2, 9
                        .set 2, 2, 8
                        .set 7, 2, 6
                        .set 0, 3, 8
                        .set 4, 3, 6
                        .set 8, 3, 3
                        .set 0, 4, 4
                        .set 3, 4, 8
                        .set 5, 4, 3
                        .set 8, 4, 1
                        .set 0, 5, 7
                        .set 4, 5, 2
                        .set 8, 5, 6
                        .set 1, 6, 6
                        .set 6, 6, 2
                        .set 7, 6, 8
                        .set 3, 7, 4
                        .set 4, 7, 1
                        .set 5, 7, 9
                        .set 8, 7, 5
                        .set 4, 8, 8
                        .set 7, 8, 7
                        .set 8, 8, 9

                solution = board.solve()

                expectedSolution = [
                        [ 5, 3, 4, 6, 7, 8, 9, 1, 2 ],
                        [ 6, 7, 2, 1, 9, 5, 3, 4, 8 ],
                        [ 1, 9, 8, 3, 4, 2, 5, 6, 7 ],
                        [ 8, 5, 9, 7, 6, 1, 4, 2, 3 ],
                        [ 4, 2, 6, 8, 5, 3, 7, 9, 1 ],
                        [ 7, 1, 3, 9, 2, 4, 8, 5, 6 ],
                        [ 9, 6, 1, 5, 3, 7, 2, 8, 4 ],
                        [ 2, 8, 7, 4, 1, 9, 6, 3, 5 ],
                        [ 3, 4, 5, 2, 8, 6, 1, 7, 9 ]
                ]

                test.deepEqual expectedSolution, solution.board

                test.done()

