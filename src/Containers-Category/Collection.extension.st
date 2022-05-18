Extension { #name : #Collection }

{ #category : #'*Containers-Category' }
Collection >> asCategory [

	^ CTCatOrderedCollection new
		  collection: self;
		  yourself
]
