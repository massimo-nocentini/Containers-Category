Class {
	#name : #Nothing,
	#superclass : #Maybe,
	#category : #'Collections-Unordered-Maybe'
}

{ #category : #'as yet unclassified' }
Nothing >> ifNothing: nBlock ifJust: jBlock [
	^ nBlock value
]
