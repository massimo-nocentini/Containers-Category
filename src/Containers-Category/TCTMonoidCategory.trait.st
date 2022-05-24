Trait {
	#name : #TCTMonoidCategory,
	#category : #'Containers-Category'
}

{ #category : #monoid }
TCTMonoidCategory >> mappend: aMonoid [

	self explicitRequirement
]

{ #category : #monoid }
TCTMonoidCategory >> mconcat: aCollectionOfMonoids [

	^ aCollectionOfMonoids
		  foldr: [ :each :acc | each mappend: acc ]
		  init: self mempty
]

{ #category : #monoid }
TCTMonoidCategory >> mempty [

	self explicitRequirement
]
