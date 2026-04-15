// ***
// *** You MUST modify this file
// ***

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "tree.h"

// DO NOT MODIFY FROM HERE --->>>
Tree * newTree(void)
{
  Tree * t = malloc(sizeof(Tree));
  t -> root = NULL;
  return t;
}

void deleteTreeNode(TreeNode * tr)
{
  if (tr == NULL)
    {
      return;
    }
  deleteTreeNode (tr -> left);
  deleteTreeNode (tr -> right);
  free (tr);
}

void freeTree(Tree * tr)
{
  if (tr == NULL)
    {
      // nothing to delete
      return;
    }
  deleteTreeNode (tr -> root);
  free (tr);
}


// <<<--- UNTIL HERE

// ***
// *** You MUST modify the follow function
// ***
#ifdef TEST_BUILDTREE
static TreeNode * buildTreeNode(int * inArray, int * postArray, int size)
{
  if (size == 0)
    {
      return NULL;
    }
 
  // Allocate and initialize the new node
  TreeNode * t = malloc(sizeof(TreeNode));
  t -> value = postArray[size - 1];
  t -> left  = NULL;
  t -> right = NULL;
 
  if (size == 1)
    {
      return t;
    }
 
  // Find the root value in inArray to split left/right subtrees
  int index = 0;
  while (inArray[index] != postArray[size - 1])
    {
      index++;
    }
  // index == number of nodes in the left subtree
 
  // Left subtree:  inArray[0..index-1], postArray[0..index-1]
  // Right subtree: inArray[index+1..size-1], postArray[index..size-2]
  t -> left  = buildTreeNode(inArray,           postArray,         index);
  t -> right = buildTreeNode(inArray + index + 1, postArray + index, size - index - 1);
 
  return t;
}
 
Tree * buildTree(int * inArray, int * postArray, int size)
{
  Tree * mainTree = newTree();
  mainTree -> root = buildTreeNode(inArray, postArray, size);
  return mainTree;
}
#endif

#ifdef TEST_PRINTPATH
static bool findAndPrint(TreeNode * node, int val)
{
  if (node == NULL)
    {
      return false;
    }
 
  // Found the target node — print it first (bottom of path)
  if (node -> value == val)
    {
      printf("%d ", node -> value);
      return true;
    }
 
  // Search left subtree
  if (findAndPrint(node -> left, val))
    {
      printf("%d ", node -> value);
      return true;
    }
 
  // Search right subtree
  if (findAndPrint(node -> right, val))
    {
      printf("%d ", node -> value);
      return true;
    }
 
  return false;
}
 
void printPath(Tree * tr, int val)
{
  if (tr == NULL || tr -> root == NULL)
    {
      return;
    }
  findAndPrint(tr -> root, val);
  printf("\n");
}
#endif