Extension { #name : #SequenceableCollection }

{ #category : #'*Containers-Category' }
SequenceableCollection >> asDifferenceCollection [

	^ CTCategoryDifferenceCollection new
		  object: self;
		  yourself
]
