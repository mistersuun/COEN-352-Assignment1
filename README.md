# COEN-352 Assignment 1: Stack Implementation & Longest Valid Parentheses

This assignment implements a generic stack data structure using linked lists and solves the longest valid parentheses problem.

## What We Built

### 1. Generic Stack (`IntegerStack<T>`)
A stack that works like a stack of toys - you can only add/remove from the top!

**Methods implemented:**
- `push(data)` - Add new item to top of stack
- `pop()` - Remove and return top item
- `peek()` - Look at top item without removing it
- `isEmpty()` - Check if stack is empty

### 2. Longest Valid Parentheses Algorithm
Finds the length of the longest valid parentheses substring using our stack.

**How it works:**
- For '(': Remember its position in the stack
- For ')': Try to match it with a '(' and calculate the length

**Examples:**
- `"()"` → Length: 2
- `"()())"` → Length: 4 (the "()()" part)
- `")())"` → Length: 2 (the "()" part)

## How to Build and Run

### Compile the code:
```bash
javac -d bin src/*.java
```

### Run (if you add a main function for testing):
```bash
java -cp bin AssignmentOne
```

### Clean compiled files:
```bash
rm -rf bin/*.class
```

## Folder Structure

- `src/` - Source code files
- `bin/` - Compiled .class files
- `lib/` - External dependencies (if any)

## Key Concepts Learned

- **Stack operations** - LIFO (Last In, First Out) principle
- **Linked list implementation** - Using head as stack top for O(1) operations
- **Algorithm design** - Using stack to store indices for efficient calculation
- **Time complexity** - All operations are O(1) for the stack, O(n) for the algorithm

## Assignment Requirements Met

✅ All stack methods implemented in ≤5 lines
✅ All operations have O(1) time complexity
✅ Parentheses algorithm correctly implemented
✅ Code compiles without errors
