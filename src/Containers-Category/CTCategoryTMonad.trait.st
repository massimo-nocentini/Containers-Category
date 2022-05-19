Trait {
	#name : #CTCategoryTMonad,
	#traits : 'CTCategoryTApplicative',
	#classTraits : 'CTCategoryTApplicative classTrait',
	#category : #'Containers-Category'
}

{ #category : #monad }
CTCategoryTMonad classSide >> fail: aString [

	self explicitRequirement
]

{ #category : #'as yet unclassified' }
CTCategoryTMonad classSide >> guard: aBoolean [

	^ aBoolean
		  ifTrue: [ self return: nil ]
		  ifFalse: [ self fail: nil ]
]

{ #category : #monad }
CTCategoryTMonad classSide >> return: anObject [

	self explicitRequirement
]

{ #category : #monad }
CTCategoryTMonad >> >> aMonad [

	^ self >>= [ :useless | aMonad ]
]

{ #category : #monad }
CTCategoryTMonad >> >>= aBlock [

	self explicitRequirement
]
