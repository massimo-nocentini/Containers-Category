"
I am the trait of monads with a state. My users implement `get`, whose result is the state, and `put:`, which replaces it.
"
Trait {
	#name : #TCTMonadStateCategory,
	#category : #'Containers-Category'
}

{ #category : #'actions api' }
TCTMonadStateCategory >> get [

	self explicitRequirement
]

{ #category : #'actions api' }
TCTMonadStateCategory >> put: aState [

	self explicitRequirement
]
