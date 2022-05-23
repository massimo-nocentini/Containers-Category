Class {
	#name : #CTCategoryMaybe,
	#superclass : #CTCategory,
	#traits : 'CTCategoryTMonad + CTCategoryTMonoid',
	#classTraits : 'CTCategoryTMonad classTrait + CTCategoryTMonoid classTrait',
	#category : #'Containers-Category'
}

{ #category : #factory }
CTCategoryMaybe class >> just: anObject [

	^ CTCategoryMaybeJust on: anObject
]

{ #category : #factory }
CTCategoryMaybe class >> nothing [

	^ CTCategoryMaybeNothing on: nil
]

{ #category : #monad }
CTCategoryMaybe >> fail: aString [

	^ self class nothing
]

{ #category : #controlling }
CTCategoryMaybe >> ifNothing: nBlock ifJust: jBlock [

	self subclassResponsibility
]

{ #category : #monoid }
CTCategoryMaybe >> mempty [

	^ self class nothing
]

{ #category : #applicative }
CTCategoryMaybe >> pure: object [

	^ object asJustMaybeCategory
]
