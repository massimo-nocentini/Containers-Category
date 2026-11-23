"
I am the trait of functors. My users implement `fmap:`, which answers a category like the receiver where the block has been applied to what the receiver wraps.
"
Trait {
	#name : #TCTFunctorCategory,
	#category : #'Containers-Category'
}

{ #category : #functor }
TCTFunctorCategory >> fmap: aBlock [

	self explicitRequirement
]
