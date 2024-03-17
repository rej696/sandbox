#!/usr/bin/env python3
'''
Parse an input CSV
Transpose the matrix
Write matrix to output CSV
'''

import sys

# -----------------------------------------------------------------------------
# File Processing Functions
# -----------------------------------------------------------------------------
def readcsv(input_file: str) -> list:
    '''Read the contents of a CSV into a 2D array'''
    matrix = []
    with open(input_file, "r") as f:
        line = ''
        while (line := f.readline()):
            # retrieve items from file, stripping whitespace and newlines
            row = [item.strip() for item in line.split(',')]
            matrix.append(row)

    return matrix

def writecsv(output_file: str, matrix: list):
    '''Write the contents of a 2D array into a CSV'''
    index = 0;
    with open(output_file, "w") as f:
        for row in matrix:
            # Right justify the strings in the matrix and write in csv format
            f.write(",".join([item.rjust(6, ' ') for item in row]))

# -----------------------------------------------------------------------------
# Transpose Functions
# -----------------------------------------------------------------------------

def transpose(matrix: list) -> list:
    '''Transpose the matrix'''
    len_row = len(matrix[0])
    len_col = len(matrix)
    # Initialise the new matrix to zeros
    new_matrix = [[0] * len_col for _ in range(len_row)]

    # Copy strings from old matrix into new matrix
    for i in range(len_row):
        for j in range(len_col):
            new_matrix[i][j] = matrix[j][i]

    return new_matrix

# -----------------------------------------------------------------------------
# Main function
# -----------------------------------------------------------------------------

def main(input_file: str, output_file: str):
    matrix = readcsv(input_file)

    matrix = transpose(matrix)

    writecsv(output_file, matrix);

if __name__ == "__main__":
    # Check filename arguments supplied
    if (len(sys.argv) == 3):
        main(sys.argv[1], sys.argv[2])
    else:
        print("Please provide a single valid csv input as an argument\n"
              + "./solution.py <input_filename>.csv <output_filename>.csv")
