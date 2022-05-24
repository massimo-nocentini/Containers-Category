Class {
	#name : #CTCategoryPole,
	#superclass : #Object,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Containers-Category-Tests'
}

{ #category : #comparing }
CTCategoryPole >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ right = anObject right and: [ left = anObject left ]
]

{ #category : #comparing }
CTCategoryPole >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ right hash bitXor: left hash
]

{ #category : #initialization }
CTCategoryPole >> initialize [

	super initialize.

	self
		left: 0;
		right: 0
]

{ #category : #initialization }
CTCategoryPole >> landLeft: n [

	^ self class new
		  left: self left + n;
		  right: self right;
		  yourself
]

{ #category : #initialization }
CTCategoryPole >> landRight: n [

	^ self class new
		  left: self left;
		  right: self right + n;
		  yourself
]

{ #category : #accessing }
CTCategoryPole >> left [

	^ left
]

{ #category : #accessing }
CTCategoryPole >> left: anObject [

	left := anObject
]

{ #category : #'as yet unclassified' }
CTCategoryPole >> maybeBanana [

	^ self asNothingMaybe asCategory
]

{ #category : #initialization }
CTCategoryPole >> maybeLandLeft: n [

	| l |
	l := self left + n.

	^ (l - self right) abs < 4
		  ifTrue: [ (self landLeft: n) asJustMaybe asCategory ]
		  ifFalse: [ self asNothingMaybe asCategory ]
]

{ #category : #initialization }
CTCategoryPole >> maybeLandRight: n [

	| r |
	r := self right + n.

	^ (self left - r) abs < 4
		  ifTrue: [ (self landRight: n) asJustMaybe asCategory ]
		  ifFalse: [ self asNothingMaybe asCategory ]
]

{ #category : #accessing }
CTCategoryPole >> right [

	^ right
]

{ #category : #accessing }
CTCategoryPole >> right: anObject [

	right := anObject
]

{ #category : #accessing }
CTCategoryPole >> value [

	^ self left @ self right
]
