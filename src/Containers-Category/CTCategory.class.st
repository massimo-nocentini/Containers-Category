Class {
	#name : #CTCategory,
	#superclass : #Object,
	#instVars : [
		'argument'
	],
	#category : #'Containers-Category'
}

{ #category : #factory }
CTCategory class >> block [

	^ CTCategoryBlock
]

{ #category : #factory }
CTCategory class >> collection [

	^ CTCategoryCollection
]

{ #category : #factory }
CTCategory class >> differenceCollection [

	^ CTCategoryDifferenceCollection
]

{ #category : #'as yet unclassified' }
CTCategory class >> maybe [

	^ CTCategoryMaybe
]

{ #category : #factory }
CTCategory class >> number [

	^ CTCategoryNumber
]

{ #category : #'instance creation' }
CTCategory class >> on: anObject [

	^ self new
		  on: anObject;
		  yourself
]

{ #category : #'as yet unclassified' }
CTCategory class >> writer [

	^ CTCategoryWriter
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

{ #category : #comparing }
CTCategory >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ argument hash
]

{ #category : #'instance creation' }
CTCategory >> on: anObject [

	argument := anObject
]
