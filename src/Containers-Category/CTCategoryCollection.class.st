Class {
	#name : #CTCategoryCollection,
	#superclass : #Object,
	#traits : 'CTCategoryTApplicative',
	#classTraits : 'CTCategoryTApplicative classTrait',
	#instVars : [
		'collection'
	],
	#category : #'Containers-Category'
}

{ #category : #'as yet unclassified' }
CTCategoryCollection >> <*> aCollectionOfBlocks [

	| array i |
	array := Array new: aCollectionOfBlocks size * collection size.

	i := 0.

	aCollectionOfBlocks do: [ :eachBlock | 
		| currified |
		currified := eachBlock currified.

		collection do: [ :eachValue | 
			i := i + 1.
			array at: i put: (currified value: eachValue) ] ].

	^ self class new
		  collection: array;
		  yourself
]

{ #category : #comparing }
CTCategoryCollection >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ collection = anObject collection
]

{ #category : #accessing }
CTCategoryCollection >> collection [

	^ collection
]

{ #category : #accessing }
CTCategoryCollection >> collection: anObject [

	collection := anObject
]

{ #category : #enumerating }
CTCategoryCollection >> do: aBlock [

	collection do: aBlock
]

{ #category : #'accessing - structure variables' }
CTCategoryCollection >> fmap: aBlock [

	^ self class new
		  collection: (collection collect: aBlock);
		  yourself
]

{ #category : #comparing }
CTCategoryCollection >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ collection hash
]

{ #category : #'as yet unclassified' }
CTCategoryCollection >> pure: object [

	collection := OrderedCollection with: object
]

{ #category : #accessing }
CTCategoryCollection >> size [

	^ collection size
]
