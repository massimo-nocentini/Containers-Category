Trait {
	#name : #CTCategoryTApplicative,
	#traits : 'CTCategoryTFunctor',
	#classTraits : 'CTCategoryTFunctor classTrait',
	#category : #'Containers-Category'
}

{ #category : #'as yet unclassified' }
CTCategoryTApplicative >> <!> aBlock [

	^ self fmap: aBlock currified
]

{ #category : #'as yet unclassified' }
CTCategoryTApplicative >> <*> anApplicative [

	self explicitRequirement
]

{ #category : #'as yet unclassified' }
CTCategoryTApplicative >> pure: object [

	self explicitRequirement
]
