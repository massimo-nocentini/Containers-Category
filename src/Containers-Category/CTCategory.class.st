"
I wrap an object, my `argument`, to give it the messages of the functors, applicatives, monads and monoids of Haskell. My subclasses get them from the traits `TCTFunctorCategory`, `TCTApplicativeCategory`, `TCTMonadCategory` and `TCTMonoidCategory`.

```smalltalk
({ 1. 2 } asCategory >>= [ :x | { x. x negated } asCategory ])
	argument. ""#(1 -1 2 -2)""
(3 asSumNumber asCategory mappend: 4 asSumNumber asCategory)
	argument. ""7""
```

Make an instance with `asCategory`, as `CTCategoryAsCategory` explains, with `on:`, or with `asWriterCategory:` for a `CTWriterCategory`, whose `on:` takes the log. Two instances are equal when they have the same class and equal arguments, and equal logs for a `CTWriterCategory`.
"
Class {
	#name : #CTCategory,
	#superclass : #Object,
	#instVars : [
		'argument'
	],
	#category : #'Containers-Category'
}

{ #category : #'instance creation' }
CTCategory class >> on: anObject [

	^ self new
		  argument: anObject;
		  yourself
]

{ #category : #comparing }
CTCategory >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ argument = anObject argument
]

{ #category : #accessing }
CTCategory >> argument [

	^ argument
]

{ #category : #'instance creation' }
CTCategory >> argument: anObject [

	argument := anObject
]

{ #category : #comparing }
CTCategory >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ argument hash
]
