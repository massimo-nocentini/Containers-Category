Class {
	#name : #CTCatOrderedCollection,
	#superclass : #OrderedCollection,
	#traits : 'CTCategoryTFunctor',
	#classTraits : 'CTCategoryTFunctor classTrait',
	#category : #'Containers-Category'
}

{ #category : #'accessing - structure variables' }
CTCatOrderedCollection >> fmap: aBlock [

	^ self collect: aBlock
]
