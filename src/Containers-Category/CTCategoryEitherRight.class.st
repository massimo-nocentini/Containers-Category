Class {
	#name : #CTCategoryEitherRight,
	#superclass : #CTCategoryEither,
	#category : #'Containers-Category'
}

{ #category : #'accessing - structure variables' }
CTCategoryEitherRight >> fmap: aBlock [

	^ self class new
		  content: (aBlock value: self content);
		  yourself
]
