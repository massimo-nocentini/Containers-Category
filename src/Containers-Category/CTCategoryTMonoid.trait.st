Trait {
	#name : #CTCategoryTMonoid,
	#category : #'Containers-Category'
}

{ #category : #monoid }
CTCategoryTMonoid classSide >> mconcat: aCollectionOfMonoids [

	^ aCollectionOfMonoids
		  foldr: [ :each :acc | each mappend: acc ]
		  init: self mempty
]

{ #category : #monoid }
CTCategoryTMonoid classSide >> mempty [

	self explicitRequirement
]

{ #category : #monoid }
CTCategoryTMonoid >> mappend: aMonoid [

	self explicitRequirement
]
