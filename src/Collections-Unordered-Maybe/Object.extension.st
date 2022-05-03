Extension { #name : #Object }

{ #category : #'*Collections-Unordered-Maybe' }
Object >> just [

	^ CTCategoryMaybeJust new
		  content: self;
		  yourself
]

{ #category : #'*Collections-Unordered-Maybe' }
Object >> nothing [

	^ CTCategoryMaybe nothing
]
