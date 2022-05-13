Extension { #name : #Object }

{ #category : #'*Containers-Category' }
Object >> just [

	^ CTCategoryMaybeJust new
		  content: self;
		  yourself
]
