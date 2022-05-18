Class {
	#name : #CTCatOrderedCollection,
	#superclass : #Object,
	#traits : 'CTCategoryTApplicative',
	#classTraits : 'CTCategoryTApplicative classTrait',
	#instVars : [
		'collection'
	],
	#category : #'Containers-Category'
}

{ #category : #'as yet unclassified' }
CTCatOrderedCollection >> <*> aCollectionOfBlocks [

	| array i |
	array := Array new: aCollectionOfBlocks size * collection size.

	i := 0.

	aCollectionOfBlocks do: [ :eachBlock | 
		collection do: [ :eachValue | 
			i := i + 1.
			array at: i put: (eachBlock currified value: eachValue) ] ].

	^ self class new
		  collection: array;
		  yourself
]

{ #category : #accessing }
CTCatOrderedCollection >> collection: anObject [

	collection := anObject
]

{ #category : #enumerating }
CTCatOrderedCollection >> do: aBlock [

	collection do: aBlock
]

{ #category : #'accessing - structure variables' }
CTCatOrderedCollection >> fmap: aBlock [

	^ self class new
		  collection: (collection collect: aBlock);
		  yourself
]

{ #category : #'as yet unclassified' }
CTCatOrderedCollection >> pure: object [

	collection := OrderedCollection with: object
]

{ #category : #accessing }
CTCatOrderedCollection >> size [

	^ collection size
]
