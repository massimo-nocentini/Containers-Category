"
```haskell
newtype Writer w a = Writer { runWriter :: (a, w) }
```

instances:

```haskell
instance (Monoid w) => Monad (Writer w) where
    return x = Writer (x, mempty)
    (Writer (x, v)) >>= f = let (Writer (y, v')) = f x in Writer (y, v `mappend` v')
```
"
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

{ #category : #comparing }
CTWriterCategory >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	^ super = anObject and: [ log = anObject log ]
]

{ #category : #monad }
CTWriterCategory >> >>= aBlock [

	| aWriterMonad |
	aWriterMonad := aBlock cull: self argument cull: self.

	^ aWriterMonad argument asWriterCategory:
		  (self log mappend: aWriterMonad log)
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

{ #category : #'instance creation' }
CTWriterCategory >> on: anObject [

	^ self class new
		  log: self log;
		  argument: anObject;
		  yourself
]

{ #category : #'monad writer' }
CTWriterCategory >> pass [

	| anArray |
	anArray := self argument.

	^ { anArray first } asWriterCategory:
		  (anArray second value: self log)
]

{ #category : #monad }
CTWriterCategory >> return: anObject [

	^ anObject asWriterCategory: self log mempty
]

{ #category : #'monad writer' }
CTWriterCategory >> writer: anObject monoid: aMonoid [

	^ anObject asWriterCategory: aMonoid
]
