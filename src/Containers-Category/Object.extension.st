Extension { #name : #Object }

{ #category : #'*Containers-Category' }
Object >> asCategory [

	^ CTCategoryAsCategory new
		  object: self;
		  yourself
]

{ #category : #'*Containers-Category' }
Object >> asJustMaybe [

	^ CTCategoryJustMaybe new
		  object: self;
		  yourself
]

{ #category : #'*Containers-Category' }
Object >> asNothingMaybe [

	^ CTCategoryNothingMaybe new
		  object: self;
		  yourself
]

{ #category : #'*Containers-Category' }
Object >> asWriterCategory: aMonoid [

	^ (CTWriterCategory on: aMonoid) on: self
]
