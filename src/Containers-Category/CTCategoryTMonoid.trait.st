Trait {
	#name : #CTCategoryTMonoid,
	#category : #'Containers-Category'
}

{ #category : #'as yet unclassified' }
CTCategoryTMonoid classSide >> mconcat: aCollectionOfMonoids [

	^ aCollectionOfMonoids
		  foldr: [ :each :acc | each mappend: acc ]
		  init: self mempty
]

{ #category : #'as yet unclassified' }
CTCategoryTMonoid classSide >> mempty [

	self explicitRequirement
]

{ #category : #'as yet unclassified' }
CTCategoryTMonoid >> mappend: aMonoid [

	self explicitRequirement
]
