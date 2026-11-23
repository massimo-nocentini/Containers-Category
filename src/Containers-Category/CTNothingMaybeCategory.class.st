"
I am a `CTMaybeCategory` without an object: `>>=` answers me and leaves its block alone, and `mappend:` answers its argument.
"
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
