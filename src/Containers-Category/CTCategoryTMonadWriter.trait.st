Trait {
	#name : #CTCategoryTMonadWriter,
	#traits : 'CTCategoryTMonad',
	#classTraits : 'CTCategoryTMonad classTrait',
	#category : #'Containers-Category'
}

{ #category : #monad }
CTCategoryTMonadWriter >> tell: aMonoid [

	self explicitRequirement
]
