Extension { #name : #Object }

{ #category : #'*Containers-Category' }
Object >> asCategory [

	^ CTCategoryAsCategory new
		  object: self;
		  yourself
]

{ #category : #'*Containers-Category' }
Object >> asJustMaybeCategory [

	^ CTCategory maybe just: self
]

{ #category : #'*Containers-Category' }
Object >> asNothingMaybeCategory [

	^ CTCategory maybe nothing
]

{ #category : #'*Containers-Category' }
Object >> asWriterCategory: aMonoid [

	^ (CTWriterCategory on: aMonoid) on: self
]
