Class {
	#name : #CTRightEitherCategory,
	#superclass : #CTEitherCategory,
	#category : #'Containers-Category'
}

{ #category : #'accessing - structure variables' }
CTRightEitherCategory >> fmap: aBlock [

	^ self class on: (aBlock cull: self argument cull: self)
]
