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

{ #category : #applicative }
CTCategoryWriter >> <*> anApplicative [

	^ (anApplicative argument value: self argument) asWriterCategory:
		  (self log mappend: anApplicative log)
]

{ #category : #comparing }
CTCategoryWriter >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	^ super = anObject and: [ log = anObject log ]
]

{ #category : #monad }
CTCategoryWriter >> >>= aBlock [

	| aWriterMonad |
	aWriterMonad := aBlock cull: self argument cull: self.

	^ aWriterMonad argument asWriterCategory:
		  (self log mappend: aWriterMonad log)
]

{ #category : #functor }
CTCategoryWriter >> fmap: aBlock [

	^ (aBlock cull: self argument cull: self) asWriterCategory: self log
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

{ #category : #applicative }
CTCategoryWriter >> pure: anObject [

	^ anObject asWriterCategory: self log mempty
]

{ #category : #monad }
CTCategoryWriter >> tell: aMonoid [

	^ nil asWriterCategory: aMonoid
]
