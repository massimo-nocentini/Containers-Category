Class {
	#name : #CTCategoryWriter,
	#superclass : #CTCategory,
	#traits : 'CTCategoryTMonad + CTCategoryTMonadWriter',
	#classTraits : 'CTCategoryTMonad classTrait + CTCategoryTMonadWriter classTrait',
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

	| aWriter |
	aWriter := self fmap: anApplicative argument.

	^ aWriter argument asWriterCategory:
		  (aWriter log mappend: anApplicative log)
]

{ #category : #comparing }
CTCategoryWriter >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	^ super = anObject and: [ log = anObject log ]
]

{ #category : #monad }
CTCategoryWriter >> >>= aBlock [

	| aWriterMonad newArgument |
	"

	(a -> b) -> m a -> m b 
	m (a -> b) -> m a -> m b
	(a -> m b) -> m a -> m b
	
	"
	aWriterMonad := aBlock cull: self argument cull: self.

	newArgument := aWriterMonad argument.

	aWriterMonad := [ :arg | newArgument ] asWriterCategory:
		                aWriterMonad log.

	^ self <*> aWriterMonad
]

{ #category : #functor }
CTCategoryWriter >> fmap: aBlock [

	^ (aBlock value: self argument) asWriterCategory: self log
]

{ #category : #comparing }
CTCategoryWriter >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: log hash
]

{ #category : #'monad writer' }
CTCategoryWriter >> listen [

	^ { 
		  self argument.
		  self log } asWriterCategory: self log
]

{ #category : #accessing }
CTCategoryWriter >> log [

	^ log
]

{ #category : #accessing }
CTCategoryWriter >> log: anObject [

	log := anObject
]

{ #category : #'monad writer' }
CTCategoryWriter >> pass [

	| anArray |
	anArray := self argument.

	^ { anArray first } asWriterCategory:
		  (anArray second value: self log)
]

{ #category : #applicative }
CTCategoryWriter >> pure: anObject [

	^ anObject asWriterCategory: self log mempty
]

{ #category : #'monad writer' }
CTCategoryWriter >> writer: anObject monoid: aMonoid [

	^ anObject asWriterCategory: aMonoid
]
