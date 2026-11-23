"
I am what `asSumNumber` answers: my `asCategory` answers a `CTSumNumberCategory` on my number.
"
Class {
	#name : #CTCategorySumNumber,
	#superclass : #CTCategoryAsCategory,
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategorySumNumber >> asCategory [

	^ CTSumNumberCategory on: self object
]
