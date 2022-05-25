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

{ #category : #'as yet unclassified' }
TCTMonadCategory >> applicativeM: aMonad [

	"(Monad m) => m (a -> b) -> m a -> m b"

	^ aMonad >>= [ :aBlock | 
	  self >>= [ :a :cat | 
	  | b |
	  b := aBlock value: a.
	  cat return: b ] ]
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

{ #category : #splitjoin }
TCTMonadCategory >> join [

	^ self join: self
]

{ #category : #splitjoin }
TCTMonadCategory >> join: aMonadOfMonad [

	^ aMonadOfMonad >>= [ :aMonad | aMonad ]
]

{ #category : #'as yet unclassified' }
TCTMonadCategory >> liftM: aBlock [

	^ self >>= [ :arg :cat | cat return: aBlock ! arg ]
]

{ #category : #monad }
TCTMonadCategory >> return: anObject [

	^ self pure: anObject
]
