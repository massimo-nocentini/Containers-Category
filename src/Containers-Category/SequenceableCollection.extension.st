Extension { #name : #SequenceableCollection }

{ #category : #'*Containers-Category' }
SequenceableCollection >> asDifferenceCollectionCategory [

	^ CTCategory differenceCollection on: [ :aSequenceable | 
		  self , aSequenceable ]
]
