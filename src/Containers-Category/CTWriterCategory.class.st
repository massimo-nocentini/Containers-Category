Class {
	#name : #CTWriterCategory,
	#superclass : #CTCategory,
	#traits : 'TCTMonadCategory + TCTMonadWriterCategory',
	#classTraits : 'TCTMonadCategory classTrait + TCTMonadWriterCategory classTrait',
	#instVars : [
		'log'
	],
	#category : #'Containers-Category'
}

{ #category : #'instance creation' }
CTWriterCategory class >> on: aMonoid [

	^ self new
		  log: aMonoid;
		  yourself
]

{ #category : #applicative }
CTWriterCategory >> <*> anApplicative [

	| aWriter |
	aWriter := self fmap: anApplicative argument.

	^ aWriter argument asWriterCategory:
		  (aWriter log mappend: anApplicative log)
]

{ #category : #comparing }
CTWriterCategory >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	^ super = anObject and: [ log = anObject log ]
]

{ #category : #monad }
CTWriterCategory >> >>= aBlock [

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
CTWriterCategory >> fmap: aBlock [

	^ (aBlock value: self argument) asWriterCategory: self log
]

{ #category : #comparing }
CTWriterCategory >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: log hash
]

{ #category : #'monad writer' }
CTWriterCategory >> listen [

	^ { 
		  self argument.
		  self log } asWriterCategory: self log
]

{ #category : #accessing }
CTWriterCategory >> log [

	^ log
]

{ #category : #accessing }
CTWriterCategory >> log: anObject [

	log := anObject
]

{ #category : #'monad writer' }
CTWriterCategory >> pass [

	| anArray |
	anArray := self argument.

	^ { anArray first } asWriterCategory:
		  (anArray second value: self log)
]

{ #category : #applicative }
CTWriterCategory >> pure: anObject [

	^ anObject asWriterCategory: self log mempty
]

{ #category : #'monad writer' }
CTWriterCategory >> writer: anObject monoid: aMonoid [

	^ anObject asWriterCategory: aMonoid
]
