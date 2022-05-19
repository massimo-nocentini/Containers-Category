Class {
	#name : #CTCategoryCollection,
	#superclass : #Object,
	#traits : 'CTCategoryTApplicative + CTCategoryTMonoid',
	#classTraits : 'CTCategoryTApplicative classTrait + CTCategoryTMonoid classTrait',
	#instVars : [
		'collection'
	],
	#category : #'Containers-Category'
}

{ #category : #monoid }
CTCategoryCollection class >> mempty [

	^ self new
		  collection: {  };
		  yourself
]

{ #category : #applicative }
CTCategoryCollection class >> pure: object [

	^ self new
		  collection: (OrderedCollection with: object);
		  yourself
]

{ #category : #applicative }
CTCategoryCollection >> <*> anApplicativeOfBlocks [

	| array i otherCollection |
	otherCollection := anApplicativeOfBlocks collection.

	array := Array new: collection size * otherCollection size.

	i := 0.

	otherCollection do: [ :eachBlock | 
		| currified |
		currified := eachBlock currified.

		collection do: [ :eachValue | 
			i := i + 1.
			array at: i put: currified ! eachValue ] ].

	^ self class new
		  collection: array;
		  yourself
]

{ #category : #comparing }
CTCategoryCollection >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ collection = anObject collection
]

{ #category : #accessing }
CTCategoryCollection >> collection [

	^ collection
]

{ #category : #accessing }
CTCategoryCollection >> collection: anObject [

	collection := anObject
]

{ #category : #functor }
CTCategoryCollection >> fmap: aBlock [

	^ self class new
		  collection: (collection collect: aBlock);
		  yourself
]

{ #category : #comparing }
CTCategoryCollection >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ collection hash
]

{ #category : #monoid }
CTCategoryCollection >> mappend: aMonoid [

	"

	instance Monoid [a] where
		mempty = []
   		mappend = (++)
	
	"

	^ self class new
		  collection: collection , aMonoid collection;
		  yourself
]
