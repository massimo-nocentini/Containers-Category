Class {
	#name : #CTCategoryMaybe,
	#superclass : #Object,
	#traits : 'CTCategoryTApplicative + CTCategoryTMonoid',
	#classTraits : 'CTCategoryTApplicative classTrait + CTCategoryTMonoid classTrait',
	#classVars : [
		'Nothing'
	],
	#category : #'Containers-Category'
}

{ #category : #'class initialization' }
CTCategoryMaybe class >> initialize [

	Nothing := CTCategoryMaybeNothing new
]

{ #category : #'as yet unclassified' }
CTCategoryMaybe class >> mempty [

	^ self nothing
]

{ #category : #accessing }
CTCategoryMaybe class >> nothing [

	^ Nothing
]

{ #category : #'as yet unclassified' }
CTCategoryMaybe class >> pure: object [

	^ CTCategory just: object
]

{ #category : #comparing }
CTCategoryMaybe >> = anObject [

	^ self class = anObject class
]

{ #category : #comparing }
CTCategoryMaybe >> hash [

	^ self class hash
]

{ #category : #'as yet unclassified' }
CTCategoryMaybe >> ifNothing: nBlock ifJust: jBlock [
	self subclassResponsibility
]
