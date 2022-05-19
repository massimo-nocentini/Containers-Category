Class {
	#name : #CTCategoryMaybeNothing,
	#superclass : #CTCategoryMaybe,
	#category : #'Containers-Category'
}

{ #category : #'accessing - structure variables' }
CTCategoryMaybeNothing >> <*> functorJust [

	^ self class new
]

{ #category : #monad }
CTCategoryMaybeNothing >> >>= aBlock [

	^ self
]

{ #category : #'accessing - structure variables' }
CTCategoryMaybeNothing >> fmap: aBlock [

	^ self class new
]

{ #category : #'as yet unclassified' }
CTCategoryMaybeNothing >> ifNothing: nBlock ifJust: jBlock [
	^ nBlock value
]

{ #category : #'as yet unclassified' }
CTCategoryMaybeNothing >> mappend: aMonoid [

	^ aMonoid
]
