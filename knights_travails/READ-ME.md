Assignment
Your task is to build a function knight_moves that shows the shortest possible way to get from one square to another by outputting all squares the knight will stop on along the way.

You can think of the board as having 2-dimensional coordinates. Your function would therefore look like:

knight_moves([0,0],[1,2]) == [[0,0],[1,2]]
knight_moves([0,0],[3,3]) == [[0,0],[1,2],[3,3]]
knight_moves([3,3],[0,0]) == [[3,3],[1,2],[0,0]]
Put together a script that creates a game board and a knight.
Treat all possible moves the knight could make as children in a tree. Don’t allow any moves to go off the board.
Decide which search algorithm is best to use for this case. Hint: one of them could be a potentially infinite series.
Use the chosen search algorithm to find the shortest path between the starting square (or node) and the ending square. Output what that full path looks like.


**Reflections**

This assignment was a real challenge, my original plan was as follows:

1. create board
    1. array of 8 arrays with 8 elements in each
2. create knight
    1. class of knight initialised with a position
    2. initially also with 8 subclasses (to signify up to 8 possible next locations *deprecated*
    3. move method within knight returns array of legal next positions
3. build a tree with knight stemming from next position through subsequent positions
4. method taking input that searches through position tree to find input
5. return shortest path to this location

Creating the board representation internally was fairly straight forward as I had faced this in the tic-tac-toe assignment and so it was just a case of extending this to 8x8.
The knight posed a greater challenge, initially I attempted to create a class with 8 instance variables for each possible movement, however I quickly found this impractical
to work with and moved to a single moves array created by a function.
The main challenge was building the tree, initally I was focused on using recursion to create child nodes. I found that this ran into issues however as the branches could be infinite and so 
there was no way to effectively stopping this. On realising this I switched the method to building out in level order (i.e. breadth first), I would not go deeper until
all nodes of a certain level were built. This allowed me to control the recursive calls more effectively. Search was also a challenge, although having gone through the earlier issue
and decided on breadth first approach this was then more straightforward.

Ultimately the code needs to be reviewed as the methods are convoluted and could do with being redesigned in closer adherence with OOP principles. After the challenges in 
completing the assignment however, pleased to have completed it - definitely the toughest assignment so far.

Time started: Friday 16th Sept 2022, 07:00:00
Latest edit: Monday 19th Sept 2022, 18:07:00
