Trait {
	#name : #TCTMonadCategory,
	#traits : 'TCTApplicativeCategory',
	#classTraits : 'TCTApplicativeCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #applicative }
TCTMonadCategory >> <*> aMonad [

	"(Monad m) => m (a -> b) -> m a -> m b"

	^ aMonad >>= [ :aBlock | 
	  self >>= [ :a :cat | 
	  | b |
	  b := aBlock value: a.
	  cat return: b ] ]
]

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

{ #category : #splitjoin }
TCTMonadCategory >> join [

	^ self >>= [ :aMonad | aMonad ]
]

{ #category : #applicative }
TCTMonadCategory >> pure: object [

	^ self return: object
]

{ #category : #monad }
TCTMonadCategory >> return: anObject [

	self explicitRequirement
]
