Trait {
	#name : #CTCategoryTApplicative,
	#traits : 'CTCategoryTFunctor',
	#classTraits : 'CTCategoryTFunctor classTrait',
	#category : #'Containers-Category'
}

{ #category : #'as yet unclassified' }
CTCategoryTApplicative >> <*> functorBlock [

	self explicitRequirement
]

{ #category : #'as yet unclassified' }
CTCategoryTApplicative >> pure: object [

	self explicitRequirement
]
