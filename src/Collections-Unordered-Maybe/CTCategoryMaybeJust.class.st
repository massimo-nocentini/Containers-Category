Class {
	#name : #CTCategoryMaybeJust,
	#superclass : #CTCategoryMaybe,
	#instVars : [
		'content'
	],
	#category : #'Collections-Unordered-Maybe'
}

{ #category : #comparing }
CTCategoryMaybeJust >> = anObject [

	^ super = anObject and: [ self content = anObject content ]
]

{ #category : #accessing }
CTCategoryMaybeJust >> content [
	^ content
]

{ #category : #accessing }
CTCategoryMaybeJust >> content: anObject [
	content := anObject
]

{ #category : #comparing }
CTCategoryMaybeJust >> hash [

	^ super hash bitXor: self content hash
]

{ #category : #'as yet unclassified' }
CTCategoryMaybeJust >> ifNothing: nBlock ifJust: jBlock [
	^ jBlock value: self
]

{ #category : #printing }
CTCategoryMaybeJust >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	content printOn: aStream.
	aStream nextPut: $)
]
