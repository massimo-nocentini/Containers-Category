Class {
	#name : #CTCollectionCategory,
	#superclass : #CTCategory,
	#traits : 'TCTMonadCategory + TCTMonoidCategory',
	#classTraits : 'TCTMonadCategory classTrait + TCTMonoidCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #monad }
CTCollectionCategory >> >>= aBlock [

	"(a -> [b]) -> [a] -> [b]"

	^ (self argument flatCollect: [ :each | 
		   (aBlock cull: each cull: self) argument ]) asCategory
]

{ #category : #monad }
CTCollectionCategory >> fail: aString [

	^ self mempty
]

{ #category : #monoid }
CTCollectionCategory >> mappend: aMonoid [

	"

	instance Monoid [a] where
		mempty = []
   		mappend = (++)
	
	"

	^ (self argument , aMonoid argument) asCategory
]

{ #category : #monoid }
CTCollectionCategory >> mempty [

	^ {  } asCategory
]

{ #category : #monad }
CTCollectionCategory >> return: anObject [

	^ { anObject } asCategory
]
