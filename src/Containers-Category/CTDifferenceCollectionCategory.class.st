"
I am the category of a difference collection: my `argument` is a block that prepends elements to the collection it is evaluated with. I am a monoid, whose `mappend:` composes two such blocks; `asOrderedCollection` evaluates mine with an empty collection.

```smalltalk
({ 1. 2 } asDifferenceCollection asCategory
	mappend: { 3 } asDifferenceCollection asCategory) asOrderedCollection ""#(1 2 3)""
```
"
Class {
	#name : #CTDifferenceCollectionCategory,
	#superclass : #CTCategory,
	#traits : 'TCTMonoidCategory',
	#classTraits : 'TCTMonoidCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #converting }
CTDifferenceCollectionCategory >> asOrderedCollection [

	^ self argument ! {  }
]

{ #category : #monoid }
CTDifferenceCollectionCategory >> mappend: aMonoid [

	^ self class on: [ :aSequenceable | 
		  aMonoid argument ! aSequenceable -! self argument ]
]

{ #category : #monoid }
CTDifferenceCollectionCategory >> mempty [

	^ self class on: [ :aSequenceable | aSequenceable ]
]
