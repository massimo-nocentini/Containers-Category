Class {
	#name : #CTCategoryMaybe,
	#superclass : #Object,
	#traits : 'CTCategoryTMonad + CTCategoryTMonoid',
	#classTraits : 'CTCategoryTMonad classTrait + CTCategoryTMonoid classTrait',
	#classVars : [
		'Nothing'
	],
	#category : #'Containers-Category'
}

{ #category : #monad }
CTCategoryMaybe class >> fail: aString [

	^ self nothing
]

{ #category : #'class initialization' }
CTCategoryMaybe class >> initialize [

	Nothing := CTCategoryMaybeNothing new
]

{ #category : #monoid }
CTCategoryMaybe class >> mempty [

	^ self nothing
]

{ #category : #accessing }
CTCategoryMaybe class >> nothing [

	^ Nothing
]

{ #category : #applicative }
CTCategoryMaybe class >> pure: object [

	^ CTCategory just: object
]

{ #category : #monad }
CTCategoryMaybe class >> return: anObject [

	^ self pure: anObject
]

{ #category : #comparing }
CTCategoryMaybe >> = anObject [

	^ self class = anObject class
]

{ #category : #comparing }
CTCategoryMaybe >> hash [

	^ self class hash
]

{ #category : #controlling }
CTCategoryMaybe >> ifNothing: nBlock ifJust: jBlock [
	self subclassResponsibility
]
