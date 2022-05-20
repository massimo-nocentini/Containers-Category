Extension { #name : #Number }

{ #category : #'*Containers-Category' }
Number >> asProductNumberCategory [

	^ CTCategory number product on: self
]

{ #category : #'*Containers-Category' }
Number >> asSumNumberCategory [

	^ CTCategory number sum on: self
]
