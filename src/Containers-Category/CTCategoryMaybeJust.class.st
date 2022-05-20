Class {
	#name : #CTCategoryMaybeJust,
	#superclass : #CTCategoryMaybe,
	#category : #'Containers-Category'
}

{ #category : #'as yet unclassified' }
CTCategoryMaybeJust >> <*> functorJust [

	^ self fmap: functorJust argument
]

{ #category : #monad }
CTCategoryMaybeJust >> >>= aBlock [

	^ aBlock cull: self argument cull: self
]

{ #category : #'accessing - structure variables' }
CTCategoryMaybeJust >> fmap: aBlock [

	^ self class on: (aBlock cull: self argument cull: self)
]

{ #category : #'as yet unclassified' }
CTCategoryMaybeJust >> ifNothing: nBlock ifJust: jBlock [
	^ jBlock value: self
]

{ #category : #'as yet unclassified' }
CTCategoryMaybeJust >> mappend: aMonoid [

	^ aMonoid
		  ifNothing: [ self ]
		  ifJust: [ :aJust | 
		  self class on: (self argument mappend: aJust argument) ]
]

{ #category : #printing }
CTCategoryMaybeJust >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.
	self argument printOn: aStream.
	aStream nextPut: $)
]
