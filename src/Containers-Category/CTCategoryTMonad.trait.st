Trait {
	#name : #CTCategoryTMonad,
	#traits : 'CTCategoryTApplicative',
	#classTraits : 'CTCategoryTApplicative classTrait',
	#category : #'Containers-Category'
}

{ #category : #monad }
CTCategoryTMonad classSide >> fail: aString [

	Error signal: aString
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
