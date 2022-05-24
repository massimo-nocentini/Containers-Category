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
