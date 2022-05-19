Class {
	#name : #CTCategoryMaybe,
	#superclass : #Object,
	#traits : 'CTCategoryTApplicative',
	#classTraits : 'CTCategoryTApplicative classTrait',
	#classVars : [
		'Nothing'
	],
	#category : #'Containers-Category'
}

{ #category : #'class initialization' }
CTCategoryMaybe class >> initialize [

	Nothing := CTCategoryMaybeNothing new
]

{ #category : #accessing }
CTCategoryMaybe class >> nothing [

	^ Nothing
]

{ #category : #'as yet unclassified' }
CTCategoryMaybe class >> pure: object [

	^ object just
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
