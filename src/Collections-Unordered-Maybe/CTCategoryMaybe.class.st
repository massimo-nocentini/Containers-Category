Class {
	#name : #CTCategoryMaybe,
	#superclass : #Object,
	#classVars : [
		'Nothing'
	],
	#category : #'Collections-Unordered-Maybe'
}

{ #category : #'class initialization' }
CTCategoryMaybe class >> initialize [

	Nothing := CTCategoryMaybeNothing new
]

{ #category : #accessing }
CTCategoryMaybe class >> nothing [

	^ Nothing
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
