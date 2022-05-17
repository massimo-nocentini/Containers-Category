Class {
	#name : #CTCategoryMaybeNothing,
	#superclass : #CTCategoryMaybe,
	#category : #'Containers-Category'
}

{ #category : #'accessing - structure variables' }
CTCategoryMaybeNothing >> fmap: aBlock [

	^ self class nothing
]

{ #category : #'as yet unclassified' }
CTCategoryMaybeNothing >> ifNothing: nBlock ifJust: jBlock [
	^ nBlock value
]
