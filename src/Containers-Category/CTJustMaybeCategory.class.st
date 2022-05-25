Class {
	#name : #CTJustMaybeCategory,
	#superclass : #CTMaybeCategory,
	#category : #'Containers-Category'
}

{ #category : #monad }
CTJustMaybeCategory >> >>= aBlock [

	^ aBlock cull: self argument cull: self
]

{ #category : #'as yet unclassified' }
CTJustMaybeCategory >> ifNothing: nBlock ifJust: jBlock [
	^ jBlock value: self
]

{ #category : #'as yet unclassified' }
CTJustMaybeCategory >> mappend: aMonoid [

	^ aMonoid
		  ifNothing: [ self ]
		  ifJust: [ :aJust | 
		  self class on: (self argument mappend: aJust argument) ]
]

{ #category : #printing }
CTJustMaybeCategory >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.
	self argument printOn: aStream.
	aStream nextPut: $)
]
