Trait {
	#name : #TCTMonadCategory,
	#traits : 'TCTApplicativeCategory',
	#classTraits : 'TCTApplicativeCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #monad }
TCTMonadCategory >> >> aMonad [

	^ self >>= [ :useless | aMonad ]
]

{ #category : #monad }
TCTMonadCategory >> >>= aBlock [

	self explicitRequirement
]

{ #category : #monad }
TCTMonadCategory >> fail: aString [

	self explicitRequirement
]

{ #category : #monad }
TCTMonadCategory >> guard: aBoolean [

	^ aBoolean
		  ifTrue: [ self return: nil ]
		  ifFalse: [ self fail: nil ]
]

{ #category : #monad }
TCTMonadCategory >> return: anObject [

	^ self pure: anObject
]
