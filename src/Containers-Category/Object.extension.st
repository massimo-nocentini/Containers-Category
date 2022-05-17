Extension { #name : #Object }

{ #category : #'*Containers-Category' }
Object >> eitherLeft [

	^ CTCategoryEitherLeft new
		  content: self;
		  yourself
]

{ #category : #'*Containers-Category' }
Object >> eitherRight [

	^ CTCategoryEitherRight new
		  content: self;
		  yourself
]

{ #category : #'*Containers-Category' }
Object >> just [

	^ CTCategoryMaybeJust new
		  content: self;
		  yourself
]
