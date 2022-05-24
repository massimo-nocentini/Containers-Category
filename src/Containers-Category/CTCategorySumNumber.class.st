Class {
	#name : #CTCategorySumNumber,
	#superclass : #CTCategoryAsCategory,
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategorySumNumber >> asCategory [

	^ CTSumNumberCategory on: self object
]
