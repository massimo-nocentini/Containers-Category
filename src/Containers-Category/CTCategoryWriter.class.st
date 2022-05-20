Class {
	#name : #CTCategoryWriter,
	#superclass : #CTCategory,
	#traits : 'CTCategoryTMonad',
	#classTraits : 'CTCategoryTMonad classTrait',
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

{ #category : #monad }
CTCategoryWriter >> >>= aBlock [

	| aWriterMonad |
	aWriterMonad := aBlock cull: self argument cull: self.

	^ (self class on: (self log mappend: aWriterMonad log)) on:
		  aWriterMonad argument
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
