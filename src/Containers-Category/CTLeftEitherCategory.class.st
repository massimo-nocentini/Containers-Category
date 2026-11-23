"
I am the left of a `CTEitherCategory`: `fmap:` answers me, and leaves its block alone.
"
Class {
	#name : #CTLeftEitherCategory,
	#superclass : #CTEitherCategory,
	#category : #'Containers-Category'
}

{ #category : #'accessing - structure variables' }
CTLeftEitherCategory >> fmap: aBlock [

	^ self
]
