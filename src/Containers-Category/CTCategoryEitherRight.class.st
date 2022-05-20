Class {
	#name : #CTCategoryEitherRight,
	#superclass : #CTCategoryEither,
	#category : #'Containers-Category'
}

{ #category : #'accessing - structure variables' }
CTCategoryEitherRight >> fmap: aBlock [

	^ self class on: (aBlock value: self argument)
]
