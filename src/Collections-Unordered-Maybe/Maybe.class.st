Class {
	#name : #Maybe,
	#superclass : #Object,
	#category : #'Collections-Unordered-Maybe'
}

{ #category : #'as yet unclassified' }
Maybe class >> just: anObject [
	^ Just new
		content: anObject;
		yourself
]

{ #category : #'as yet unclassified' }
Maybe class >> nothing [
	^ Nothing new
]

{ #category : #'as yet unclassified' }
Maybe >> ifNothing: nBlock ifJust: jBlock [
	self subclassResponsibility
]
