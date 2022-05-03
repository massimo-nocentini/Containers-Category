Class {
	#name : #CTCategoryMaybeNothing,
	#superclass : #CTCategoryMaybe,
	#category : #'Containers-Category'
}

{ #category : #'as yet unclassified' }
CTCategoryMaybeNothing >> ifNothing: nBlock ifJust: jBlock [
	^ nBlock value
]
