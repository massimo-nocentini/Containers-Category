Class {
	#name : #CTCategoryNumber,
	#superclass : #CTCategory,
	#instVars : [
		'number'
	],
	#category : #'Containers-Category'
}

{ #category : #comparing }
CTCategoryNumber >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ number = anObject number
]

{ #category : #comparing }
CTCategoryNumber >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ number hash
]

{ #category : #accessing }
CTCategoryNumber >> number [

	^ number
]

{ #category : #accessing }
CTCategoryNumber >> number: anObject [

	number := anObject
]
