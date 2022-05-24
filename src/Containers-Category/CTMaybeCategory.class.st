Class {
	#name : #CTMaybeCategory,
	#superclass : #CTCategory,
	#traits : 'CTCategoryTMonad + CTCategoryTMonoid',
	#classTraits : 'CTCategoryTMonad classTrait + CTCategoryTMonoid classTrait',
	#category : #'Containers-Category'
}

{ #category : #factory }
CTMaybeCategory class >> just: anObject [

	^ CTJustMaybeCategory on: anObject
]

{ #category : #factory }
CTMaybeCategory class >> nothing [

	^ CTNothingMaybeCategory on: nil
]

{ #category : #monad }
CTMaybeCategory >> fail: aString [

	^ self class nothing
]

{ #category : #controlling }
CTMaybeCategory >> ifNothing: nBlock ifJust: jBlock [

	self subclassResponsibility
]

{ #category : #monoid }
CTMaybeCategory >> mempty [

	^ self class nothing
]

{ #category : #applicative }
CTMaybeCategory >> pure: object [

	^ object asJustMaybeCategory
]
