Class {
	#name : #CTCategoryMaybeNothing,
	#superclass : #CTCategoryMaybe,
	#category : #'Collections-Unordered-Maybe'
}

{ #category : #'as yet unclassified' }
CTCategoryMaybeNothing >> ifNothing: nBlock ifJust: jBlock [
	^ nBlock value
]
