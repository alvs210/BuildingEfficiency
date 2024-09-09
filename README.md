# BuildingEfficiency
Achieved 5th most time- and space- efficient algorithm! This is a C program called "BuildEff" (short for Building Efficiency) to identify the most energy efficient Duke building (per square foot) in the input file provided. Converted it into MIPS Assembly language too while mantaining efficiency.

Assignment for BuildEff in C: [Click Here](https://people.ee.duke.edu/~jab/ece250/homeworks/homework1.pdf)
Assignment for BuildEff in Assembly: [Click Here](https://people.ee.duke.edu/~jab/ece250/homeworks/homework2.pdf)

# Assignment Details

Write a C program called BuildEff (short for Building Efficiency) to identify the most energy efficient
building (per square foot) in the input file provided. The tool will take a filename as an input (eg.,
“./BuildEff buildinginfo.txt”). The format of this file is file is a series of
building stats, where each entry is 3 lines long. The first line is the name of a building (a string with no
spaces), the second line is the square footage of the building (an int, which you will need to typecast as a
float later), and the third line is the annual amount of electricity used per year (in KwH – Kilowatt hours))
(a float). After the last building in the list, the last line of the file is the string “DONE”. For example:

HudsonAnnex
30000
522000.0
FitzpatrickCIEMAS
332178
4686414.2
DONE

Your program should output a number of lines equal to the number of buildings and each line is the
building’s name and energy efficiency in kWh per square foot per year. The lines should be sorted in
descending order of kWh per square foot per year (least efficient building first), and you must write your
own sorting function (you can’t just use the qsort library function). Buildings with equal efficiency
should be sorted alphabetically (e.g. based on the strcmp function). For example:

HudsonAnnex 17.4
FitzCIEMAS 14.10814
FancyHall 12.6
MessyHall 12.6
