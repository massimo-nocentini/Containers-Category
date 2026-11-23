"
I hold an `object` that can be seen as a category in more than one way: the class that I have tells which, and my `asCategory` answers the category itself. A number, for instance, makes a monoid by sum or by product.

```smalltalk
3 asSumNumber asCategory. ""a CTSumNumberCategory""
3 asProductNumber asCategory. ""a CTProductNumberCategory""
```

These messages answer an instance of my subclasses:

- `asJustMaybe` and `asNothingMaybe`, for any object;
- `asSumNumber` and `asProductNumber`, for numbers;
- `asDifferenceCollection` and `asProbabilityDistribution`, for sequenceable collections;
- `asState`, for blocks.

Collections and blocks have an `asCategory` that needs no such step. The `asCategory` of any other object answers an instance of mine, whose own `asCategory` is a subclass responsibility.
"
Class {
	#name : #CTCategoryAsCategory,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryAsCategory >> asCategory [

	self subclassResponsibility
]

{ #category : #accessing }
CTCategoryAsCategory >> object [

	^ object
]

{ #category : #accessing }
CTCategoryAsCategory >> object: anObject [

	object := anObject
]
