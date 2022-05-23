Trait {
	#name : #CTCategoryTMonad,
	#traits : 'CTCategoryTApplicative',
	#classTraits : 'CTCategoryTApplicative classTrait',
	#category : #'Containers-Category'
}

{ #category : #monad }
CTCategoryTMonad >> >> aMonad [

	^ self >>= [ :useless | aMonad ]
]

{ #category : #monad }
CTCategoryTMonad >> >>= aBlock [

	self explicitRequirement
]

{ #category : #monad }
CTCategoryTMonad >> fail: aString [

	self explicitRequirement
]

{ #category : #monad }
CTCategoryTMonad >> guard: aBoolean [

	^ aBoolean
		  ifTrue: [ self return: nil ]
		  ifFalse: [ self fail: nil ]
]

{ #category : #monad }
CTCategoryTMonad >> return: anObject [

	^ self pure: anObject
]
