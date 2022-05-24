Class {
	#name : #CTNothingMaybeCategory,
	#superclass : #CTMaybeCategory,
	#category : #'Containers-Category'
}

{ #category : #'accessing - structure variables' }
CTNothingMaybeCategory >> <*> functorJust [

	^ self
]

{ #category : #monad }
CTNothingMaybeCategory >> >>= aBlock [

	^ self
]

{ #category : #'accessing - structure variables' }
CTNothingMaybeCategory >> fmap: aBlock [

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
