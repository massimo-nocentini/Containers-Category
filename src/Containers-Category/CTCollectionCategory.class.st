Class {
	#name : #CTCollectionCategory,
	#superclass : #CTCategory,
	#traits : 'CTCategoryTMonad + CTCategoryTMonoid',
	#classTraits : 'CTCategoryTMonad classTrait + CTCategoryTMonoid classTrait',
	#category : #'Containers-Category'
}

{ #category : #applicative }
CTCollectionCategory >> <*> anApplicativeOfBlocks [

	| array i otherCollection collection |
	collection := self argument.
	otherCollection := anApplicativeOfBlocks argument.

	array := Array new: collection size * otherCollection size.

	i := 0.

	otherCollection do: [ :eachBlock | 
		| currified |
		currified := eachBlock currified.

		collection do: [ :eachValue | 
			i := i + 1.
			array at: i put: currified ! eachValue ] ].

	^ self class on: array
]

{ #category : #monad }
CTCollectionCategory >> >>= aBlock [

	^ self class on:
		  ((self fmap: aBlock) argument flatCollect: [ :each | 
			   each argument ])
]

{ #category : #monad }
CTCollectionCategory >> fail: aString [

	^ self mempty
]

{ #category : #functor }
CTCollectionCategory >> fmap: aBlock [

	^ self class on:
		  (self argument collect: [ :each | aBlock cull: each cull: self ])
]

{ #category : #monoid }
CTCollectionCategory >> mappend: aMonoid [

	"

	instance Monoid [a] where
		mempty = []
   		mappend = (++)
	
	"

	^ self class on: self argument , aMonoid argument
]

{ #category : #monoid }
CTCollectionCategory >> mempty [

	^ self class on: {  }
]

{ #category : #applicative }
CTCollectionCategory >> pure: object [

	^ self class on: { object }
]
