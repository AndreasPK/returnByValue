Consider a expression like this:

```
  case scrut of
    p1 -> e1
    p2 -> e2
```

Each expression that allocates has to be associatd with a heap check, but multiple might be associated with a common one.

Under GHCs current code gen scheme we generate heap checks for each branch.
A failed heap check returns control to the rts, and as such requires both a return address and a info table.

Currently the return point is in the common case after evaluating scrut but before we branch on the returned tag.

In pseudo code:

```
case:
  if !(needsEval scrut) then goto branch;
  eval scrut [returns to branch];
<infoTable>
branch:
  switch(tagOf scrut) {
    p1:
      CheckHeap [returns to branch]
      <e1>
      break;
    p2:
      CheckHeap [returns to branch]
      <e1>
      break;
  }
  jmp(continuation)
```

It's crucial to note that in this scheme `branch` and it's info table does not only provide a
return point for evaluating `scrut`. It is also used as return point for the heap checks
within the branches.

Now when we skip the call to eval scrut we have to make sure we do keep this pattern and don't
create individual return points for each branch. Otherwise we pollute the I-Cache with them and
at a cost of 16 bytes per piece this is more than enough to offset any potential gain
we would get from executing fewer instructions.

Currently however GHC ALWAYS emites the call to evaluate the scrutinee for boxed values.  
So this will be a small, but non-trivial change.