fun yj_calcGrid(liveCells: Set<Pair<Int, Int>>): Set<Pair<Int, Int>> {
    val neighbourCounts = mutableMapOf<Pair<Int, Int>, Int>()

    // Count neighbours for each live cell
    liveCells.forEach { (x, y) ->
        (-1..1).forEach { dx ->
            (-1..1).forEach { dy ->
                if (!(dx == 0 && dy == 0)) {
                    val neighbour = Pair(x + dx, y + dy)
                    neighbourCounts[neighbour] = neighbourCounts.getOrDefault(neighbour, 0) + 1
                }
            }
        }
    }

    // Determine next generation of live cells
    return neighbourCounts.filter { (cell, count) ->
        count == 3 || (count == 2 && cell in liveCells)
    }.keys.toSet()
}
/* // example usage:
fun main() {
    val initialLiveCells = setOf(Pair(1, 2), Pair(2, 2), Pair(3, 2))
    val nextGenLiveCells = yj_calcGrid(initialLiveCells)

    println("Cells alive in the next generation:")
    nextGenLiveCells.forEach { println(it) }
}
*/
