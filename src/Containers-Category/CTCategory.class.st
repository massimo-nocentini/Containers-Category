Class {
	#name : #CTCategory,
	#superclass : #Object,
	#instVars : [
		'argument'
	],
	#category : #'Containers-Category'
}

{ #category : #'instance creation' }
CTCategory class >> on: anObject [

	^ self new
		  argument: anObject;
		  yourself
]

{ #category : #comparing }
CTCategory >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ argument = anObject argument
]

{ #category : #accessing }
CTCategory >> argument [

	^ argument
]

{ #category : #'instance creation' }
CTCategory >> argument: anObject [

	argument := anObject
]

{ #category : #comparing }
CTCategory >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ argument hash
]
