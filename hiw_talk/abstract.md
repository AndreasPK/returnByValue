An abstract is important, it helps the reader know if they paper is worth their investment of time.
It is important to `sell' the paper, but be careful not to \emph{oversell}.

Pointer tags and how we can use them.

Pointer tagging has value.

Tagged pointers and their invariants.


* What is pointer tagging.

What is Pointer tagging? 12
Why is it useful? 20

When is a pointer tagged? 50
Ongoing work - how to best prove that point! 100
Performance benefits: Current State: “ ~10% faster container benchmarks”
Discussion: How to best solve these problems.



Tagging Tags: Infering the presence of pointer tags at compile time.

Pointer tagging allows GHC to efficiently encode information about evaluated objects in the pointer to the object.
However GHC never assumes the presence of a tag on a pointer. Therefore neccesitating a check for tag presence whenever tag information might be used.

This is even true for strict fields, which as a rule can't contain bottom values and should therefore only contain tagged pointers.
There are however exceptions to this rule which prevent us from taking advantage of this fact.
We explain how we can ensure the invariant that all strict fields will always contain tagged references.

This change can have a surprisingly large impact on code making heavy use of strict fields, with a WIP branch already giving
speedups of <~8% - verify numbers> for the benchmark suite of the containers package. <add more benchmarks if possible>

While this seems like a trivial thing to do there a few surprising issues with a naive implementation.
Among other things we need to implement an analysis to infer taggedness of pointers in order to uphold this invariant without performance loss.

We present our current analysis which is based on the STG representation of programs and it's results.
As this is work in progress we also hope for a discussion and feedback on our approach and potential alternatives.



