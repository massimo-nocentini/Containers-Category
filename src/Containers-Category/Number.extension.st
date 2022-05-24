Extension { #name : #Number }

{ #category : #'*Containers-Category' }
Number >> asProductNumber [

	^ CTCategoryProductNumber new
		  object: self;
		  yourself
]

{ #category : #'*Containers-Category' }
Number >> asSumNumber [

	^ CTCategorySumNumber new
		  object: self;
		  yourself
]

{ #category : #'*Containers-Category' }
Number >> asSumNumberCategory [

	^ CTCategory number sum on: self
]
