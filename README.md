# Homework 13: Printing the Path in a Binary Tree

## Goals
This is the second part of two assignments. This part asks you to
print the path from a certain node to the root.

You will learn 
* Construct binary trees from in-order and post-order expressions
* Find the path from a node (not necessarily a leaf node) to the root

## Background

### 1. Path to Root

Consider a binary tree structure as follows:
```
        3    <– root
      /   \
     5      1  
    /  \     \
   6    7     8
    \        /  \
    10      2    4    <– leaves
```

The path from node 10 includes 10, 6, 5, and 3. The path from 8 includes 8, 1,
and 3. Please notice that this is not necessarily a binary search tree.

For simplicity, this assignment asks you to print the path from bottom to top (the root is printed last).

## What do you need to do?

You'll need to change one file `tree.c`.

Inside `tree.c`, you can use your function `Tree * buildTree(int * inArray, int * postArray, int size)` from HW12.
This `buildTree` function takes the in-order and post-order traversal as input and build a binary tree 
based on it.

And then, you'll need to implement the function `void printPath(Tree * tr, int val)`. The `printPath` function
prints the paths from the node with value `val` to the root. The path should be printed from bottom to top. In other words,
the root is printed last.

### 1. How to test your code

There are 6 test cases provided to you in the `testcases` directory. 
The corresponding printed paths for the 6 test cases are in the `expected` directory.

You'll notice two paths for each test case in the `expected` directory. The first is the path from 
the first node in the in-order traversal to the root. The second is the path from 
the first node in the post-order traversal to the root.

For example in testcase 2, the binary tree is:

```
         199    <– root
        /  \
       90  275
        \
        110     <– leaves
```
* The first line in `expected2` is the path from node 90 (the first node in `test2in`) to the root:
```
90 199
```
* The second line in `expected2` is the path from node 110 (the first node in `test2post`) to the root:
```
110 90 199
```

You may notice from the `main` function in `main.c` that your program requires two inputs:
```
argv[1]: input file name for in-order traversal
argv[2]: input file name for post-order traversal
```

Thus, suppose your executable file is named `hw13`, you may run your the program with the following command:
```
./hw13 testcases/test2in testcases/test2post > output2
```

You may further use the `diff` command to compare your output with the expected output in the  `expected` directory.

Remember to use `valgrind` to check memory. 

## Grading
You will lose 1 point for every 1 byte of memory leak. In other words, if your program leaks 100 or more bytes, you will **receive zero**.

## Submission
Please submit the following file(s):
1. `tree.c`

