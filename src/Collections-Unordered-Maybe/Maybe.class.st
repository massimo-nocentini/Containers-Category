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

{ #category : #comparing }
Maybe >> = anObject [

	^ self class = anObject class
]

{ #category : #comparing }
Maybe >> hash [

	^ self class hash
]

{ #category : #'as yet unclassified' }
Maybe >> ifNothing: nBlock ifJust: jBlock [
	self subclassResponsibility
]
