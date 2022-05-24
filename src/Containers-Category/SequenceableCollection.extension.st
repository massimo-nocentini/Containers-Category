Extension { #name : #SequenceableCollection }

{ #category : #'*Containers-Category' }
SequenceableCollection >> asDifferenceCollection [

	^ CTCategoryDifferenceCollection new
		  collection: self;
		  yourself
]
