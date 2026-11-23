"
I am the category of a collection, which is my `argument`: a monad, where `>>=` evaluates the block with each element and concatenates the collections that it answers, and a monoid, where `mappend:` is the concatenation and `mempty` the empty collection.

```smalltalk
({ 1. 2 } asCategory >>= [ :x | { x. x negated } asCategory ]) argument. ""#(1 -1 2 -2)""
({ 1. 2 } asCategory mappend: { 3 } asCategory) argument. ""#(1 2 3)""
({ 1. 2. 3. 4 } asCategory >>= [ :each :category |
	(category guard: each even) >> (category return: each) ]) argument. ""#(2 4)""
```
"
Class {
	#name : #CTCollectionCategory,
	#superclass : #CTCategory,
	#traits : 'TCTMonadCategory + TCTMonoidCategory',
	#classTraits : 'TCTMonadCategory classTrait + TCTMonoidCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #monad }
CTCollectionCategory >> >>= aBlock [

	"(a -> [b]) -> [a] -> [b]"

	^ (self argument flatCollect: [ :each | 
		   (aBlock cull: each cull: self) argument ]) asCategory
]

{ #category : #monad }
CTCollectionCategory >> fail: aString [

	^ self mempty
]

{ #category : #monoid }
CTCollectionCategory >> mappend: aMonoid [

	"

	instance Monoid [a] where
		mempty = []
   		mappend = (++)
	
	"

	^ (self argument , aMonoid argument) asCategory
]

{ #category : #monoid }
CTCollectionCategory >> mempty [

	^ {  } asCategory
]

{ #category : #monad }
CTCollectionCategory >> return: anObject [

	^ { anObject } asCategory
]
