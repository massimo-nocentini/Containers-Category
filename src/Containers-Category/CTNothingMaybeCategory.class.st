Class {
	#name : #CTNothingMaybeCategory,
	#superclass : #CTMaybeCategory,
	#category : #'Containers-Category'
}

{ #category : #monad }
CTNothingMaybeCategory >> >>= aBlock [

	^ self
]

{ #category : #'as yet unclassified' }
CTNothingMaybeCategory >> ifNothing: nBlock ifJust: jBlock [

	^ nBlock value
]

{ #category : #'as yet unclassified' }
CTNothingMaybeCategory >> mappend: aMonoid [

	^ aMonoid
]
