Trait {
	#name : #CTCategoryTFunctor,
	#category : #'Containers-Category'
}

{ #category : #functor }
CTCategoryTFunctor >> fmap: aBlock [

	self explicitRequirement
]
