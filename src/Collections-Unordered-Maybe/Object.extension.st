Extension { #name : #Object }

{ #category : #'*Collections-Unordered-Maybe' }
Object >> just [

	^ Maybe just: self
]

{ #category : #'*Collections-Unordered-Maybe' }
Object >> nothing [

	^ Maybe nothing
]
