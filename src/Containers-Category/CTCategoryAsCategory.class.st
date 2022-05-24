Class {
	#name : #CTCategoryAsCategory,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryAsCategory >> asCategory [

	self subclassResponsibility
]

{ #category : #accessing }
CTCategoryAsCategory >> object [

	^ object
]

{ #category : #accessing }
CTCategoryAsCategory >> object: anObject [

	object := anObject
]
