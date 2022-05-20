Class {
	#name : #CTCategoryWriter,
	#superclass : #CTCategory,
	#traits : 'CTCategoryTMonadWriter',
	#classTraits : 'CTCategoryTMonadWriter classTrait',
	#instVars : [
		'log'
	],
	#category : #'Containers-Category'
}

{ #category : #'instance creation' }
CTCategoryWriter class >> on: aMonoid [

	^ self new
		  log: aMonoid;
		  yourself
]

{ #category : #comparing }
CTCategoryWriter >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ log = anObject log and: [ argument = anObject argument1 ]
]

{ #category : #monad }
CTCategoryWriter >> >>= aBlock [

	| aWriterMonad |
	aWriterMonad := aBlock cull: self argument cull: self.

	^ (self class on: (self log mappend: aWriterMonad log)) on:
		  aWriterMonad argument
]

{ #category : #accessing }
CTCategoryWriter >> argument1 [

	^ argument
]

{ #category : #comparing }
CTCategoryWriter >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ log hash bitXor: argument hash
]

{ #category : #accessing }
CTCategoryWriter >> log [

	^ log
]

{ #category : #accessing }
CTCategoryWriter >> log: anObject [

	log := anObject
]

{ #category : #monad }
CTCategoryWriter >> return: anObject [

	^ (self class on: log mempty) on: anObject
]

{ #category : #monad }
CTCategoryWriter >> tell: aMonoid [

	^ nil asWriterCategory: aMonoid
]
