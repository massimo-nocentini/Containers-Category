Trait {
	#name : #CTCategoryTMonoid,
	#category : #'Containers-Category'
}

{ #category : #monoid }
CTCategoryTMonoid >> mappend: aMonoid [

	self explicitRequirement
]

{ #category : #monoid }
CTCategoryTMonoid >> mconcat: aCollectionOfMonoids [

	^ aCollectionOfMonoids
		  foldr: [ :each :acc | each mappend: acc ]
		  init: self mempty
]

{ #category : #monoid }
CTCategoryTMonoid >> mempty [

	self explicitRequirement
]
