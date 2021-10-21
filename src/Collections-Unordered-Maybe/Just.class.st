Class {
	#name : #Just,
	#superclass : #Maybe,
	#instVars : [
		'content'
	],
	#category : #'Collections-Unordered-Maybe'
}

{ #category : #comparing }
Just >> = anObject [

	^ super = anObject and: [ self content = anObject content ]
]

{ #category : #accessing }
Just >> content [
	^ content
]

{ #category : #accessing }
Just >> content: anObject [
	content := anObject
]

{ #category : #comparing }
Just >> hash [

	^ super hash bitXor: self content hash
]

{ #category : #'as yet unclassified' }
Just >> ifNothing: nBlock ifJust: jBlock [
	^ jBlock value: self
]

{ #category : #printing }
Just >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	content printOn: aStream.
	aStream nextPut: $)
]
